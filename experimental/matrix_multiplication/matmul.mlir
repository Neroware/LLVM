// Solves C = AB

module attributes {gpu.container_module} {

gpu.module @kernels {
    gpu.func @kernel_matmul(%ptr_A : memref<1024x1024xi64>, %ptr_B : memref<1024x1024xi64>, %ptr_C : memref<1024x1024xi64>) 
        kernel
    {
        // Constants
        %cst_0 = arith.constant 0 : i64
        %cst_1 = arith.constant 1 : i64
        %cst_2 = arith.constant 2 : i64
        %cst_3 = arith.constant 3 : i64
        %cst_4 = arith.constant 4 : i64
        %cst_5 = arith.constant 5 : i64
        %cst_10 = arith.constant 10 : i64
        %csti_0 = arith.constant 0 : index
        %csti_1 = arith.constant 1 : index
        %csti_16 = arith.constant 16 : index
        %csti_1023 = arith.constant 1023 : index
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
        memref.store %cst_0, %ptr_C[%kIdX, %kIdY] : memref<1024x1024xi64>

        // Perform c_ij = sum_k(a_ik * b_kj)
        scf.for %idx0 = %csti_0 to %csti_1023 step %csti_1 {
            %tmp_a = memref.load %ptr_A[%kIdX, %idx0] : memref<1024x1024xi64>
            %tmp_b = memref.load %ptr_B[%idx0, %kIdY] : memref<1024x1024xi64>
            %tmp_c = memref.load %ptr_C[%kIdX, %kIdY] : memref<1024x1024xi64>
            %tmp_ab = arith.muli %tmp_a, %tmp_b : i64
            %c = arith.addi %tmp_c, %tmp_ab : i64
            memref.store %c, %ptr_C[%kIdX, %kIdY] : memref<1024x1024xi64>
        }

        gpu.return
    }
}

func.func @main() -> i64 {
    // Constants
    %cst_0 = arith.constant 0 : i64
    %cst_1 = arith.constant 1 : i64
    %cst_2 = arith.constant 2 : i64
    %cst_3 = arith.constant 3 : i64
    %cst_4 = arith.constant 4 : i64
    %cst_5 = arith.constant 5 : i64
    %cst_10 = arith.constant 10 : i64
    %csti_0 = arith.constant 0 : index
    %csti_1 = arith.constant 1 : index
    %csti_16 = arith.constant 16 : index
    %csti_32 = arith.constant 32 : index
    %csti_1023 = arith.constant 1023 : index
    %csti_1024 = arith.constant 1024 : index

    // Init matrices
    %mat_A = memref.alloc() : memref<1024x1024xi64>
    %mat_B = memref.alloc() : memref<1024x1024xi64>
    scf.for %idx0 = %csti_0 to %csti_1023 step %csti_1 {
        scf.for %idx1 = %csti_0 to %csti_1023 step %csti_1 {
            memref.store %cst_1, %mat_A[%idx0, %idx1] : memref<1024x1024xi64>
            memref.store %cst_1, %mat_B[%idx0, %idx1] : memref<1024x1024xi64>
        }
    }

    // Alloctate Memory for C
    %mat_C = memref.alloc() : memref<1024x1024xi64>

    // Launch kernels
    %t0 = gpu.wait async
    %foo = gpu.launch_func
        async
        [%t0]
        @kernels::@kernel_matmul
        blocks in (%csti_32, %csti_32, %csti_1)
        threads in (%csti_32, %csti_32, %csti_1)
        args(%mat_A : memref<1024x1024xi64>, %mat_B : memref<1024x1024xi64>, %mat_C : memref<1024x1024xi64>)

    return %cst_0 : i64
}

} // END module