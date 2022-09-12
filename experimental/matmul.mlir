// Solves C = AB with a_{ij} = b_{ij} = 1

module attributes {
    gpu.container_module
    //spv.target_env = #spv.target_env<
    //    #spv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_8bit_storage]>, #spv.resource_limits<>>
} {

gpu.module @kernels {
    gpu.func @kernel_matmul(%mat_A : memref<1024x1024xi32>, %mat_B : memref<1024x1024xi32>, %mat_C : memref<1024x1024xi32>)
        kernel attributes { spv.entry_point_abi = #spv.entry_point_abi<local_size = dense<[1, 1, 1]>: vector<3xi32>>} {
        // Constants
        %cst_0 = arith.constant 0 : i32

        // Indices
        %csti_0 = arith.constant 0 : index
        %csti_1 = arith.constant 1 : index
        %csti_1024 = arith.constant 1024 : index

        %tIdX = gpu.thread_id x
        %tIdY = gpu.thread_id y
        %bDimX = gpu.block_dim x
        %bDimY = gpu.block_dim y
        %bIdX = gpu.block_id x
        %bIdY = gpu.block_id y

        // Kernel Indices
        %kIdXtmp = arith.muli %bIdX, %bDimX : index
        %kIdX = arith.addi %kIdXtmp, %tIdX : index
        %kIdYtmp = arith.muli %bIdY, %bDimY : index
        %kIdY = arith.addi %kIdYtmp, %tIdY : index

        // Init value in C to zero
        memref.store %cst_0, %mat_C[%kIdX, %kIdY] : memref<1024x1024xi32>

        // Perform c_ij = sum_k(a_ik * b_kj)
        scf.for %idx0 = %csti_0 to %csti_1024 step %csti_1 {
            %tmp_a = memref.load %mat_A[%kIdX, %idx0] : memref<1024x1024xi32>
            %tmp_b = memref.load %mat_B[%idx0, %kIdY] : memref<1024x1024xi32>
            %tmp_c = memref.load %mat_C[%kIdX, %kIdY] : memref<1024x1024xi32>
            %tmp_ab = arith.muli %tmp_a, %tmp_b : i32
            %c = arith.addi %tmp_c, %tmp_ab : i32
            memref.store %c, %mat_C[%kIdX, %kIdY] : memref<1024x1024xi32>
        }

        gpu.return
    }
}

func.func @main() -> i32 {
    // Constants
    %cst_0 = arith.constant 0 : i32
    %cst_1 = arith.constant 1 : i32
    // Indices
    %csti_0 = arith.constant 0 : index
    %csti_1 = arith.constant 1 : index
    %csti_16 = arith.constant 16 : index
    %csti_32 = arith.constant 32 : index
    %csti_1023 = arith.constant 1023 : index
    %csti_1024 = arith.constant 1024 : index

    // Init matrices
    %mat_A = memref.alloc() : memref<1024x1024xi32>
    %mat_B = memref.alloc() : memref<1024x1024xi32>
    scf.for %idx0 = %csti_0 to %csti_1024 step %csti_1 {
        scf.for %idx1 = %csti_0 to %csti_1024 step %csti_1 {
            memref.store %cst_1, %mat_A[%idx0, %idx1] : memref<1024x1024xi32>
            memref.store %cst_1, %mat_B[%idx0, %idx1] : memref<1024x1024xi32>
        }
    }
    // Alloctate Memory for C
    %mat_C = memref.alloc() : memref<1024x1024xi32>

    // Cast to flat array
    %cast_A = memref.cast %mat_A : memref<1024x1024xi32> to memref<*xi32>
    %cast_B = memref.cast %mat_B : memref<1024x1024xi32> to memref<*xi32>
    %cast_C = memref.cast %mat_C : memref<1024x1024xi32> to memref<*xi32>

    // Register host memory
    gpu.host_register %cast_A : memref<*xi32>
    gpu.host_register %cast_B : memref<*xi32>
    gpu.host_register %cast_C : memref<*xi32>

    // Launch Kernel Function
    gpu.launch_func @kernels::@kernel_matmul
        blocks in (%csti_32, %csti_32, %csti_1)
        threads in (%csti_32, %csti_32, %csti_1)
        args(%mat_A : memref<1024x1024xi32>, %mat_B : memref<1024x1024xi32>, %mat_C : memref<1024x1024xi32>)

    %ret = memref.load %mat_C[%csti_1023, %csti_1023] : memref<1024x1024xi32>
    return %ret : i32
}

} // End module

// CHECK: 1024