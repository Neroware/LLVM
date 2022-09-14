// RUN: mlir-opt %s \
// RUN:   -gpu-kernel-outlining \
// RUN:   -pass-pipeline='func.func(convert-scf-to-cf),gpu.module(strip-debuginfo,convert-scf-to-cf,convert-gpu-to-nvvm,gpu-to-cubin)' \
// RUN:   -gpu-async-region -gpu-to-llvm \
// RUN:   -async-to-async-runtime -async-runtime-ref-counting \
// RUN:   -convert-async-to-llvm -convert-func-to-llvm \
// RUN: | mlir-cpu-runner \
// RUN:   --shared-libs=%linalg_test_lib_dir/libmlir_cuda_runtime%shlibext \
// RUN:   --shared-libs=%linalg_test_lib_dir/libmlir_async_runtime%shlibext \
// RUN:   --shared-libs=%linalg_test_lib_dir/libmlir_runner_utils%shlibext \
// RUN:   --entry-point-result=i32 -O0 \
// RUN: | FileCheck %s

// Solves C = AB with a_ij = b_ij = 1

module attributes {gpu.container_module} {

gpu.module @kernels {
    gpu.func @kernel_matmul(%dim : index, %in : memref<2x?x?xi32>, %out : memref<?x?xi32>)
        kernel attributes { spv.entry_point_abi = #spv.entry_point_abi<local_size = dense<[1, 1, 1]>: vector<3xi32>>} {
        // Constants
        %c0     = arith.constant 0 : i32
        // Indices
        %ci0    = arith.constant 0 : index
        %ci1    = arith.constant 1 : index

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
        memref.store %c0, %out[%kIdX, %kIdY] : memref<?x?xi32>

        // Perform c_ij = sum_k(a_ik * b_kj)
        scf.for %idx0 = %ci0 to %dim step %ci1 {
            %tmp_a = memref.load %in[%ci0, %kIdX, %idx0] : memref<2x?x?xi32>
            %tmp_b = memref.load %in[%ci1, %idx0, %kIdY] : memref<2x?x?xi32>
            %tmp_c = memref.load %out[%kIdX, %kIdY] : memref<?x?xi32>
            %tmp_ab = arith.muli %tmp_a, %tmp_b : i32
            %c = arith.addi %tmp_c, %tmp_ab : i32
            memref.store %c, %out[%kIdX, %kIdY] : memref<?x?xi32>
        }

        gpu.return
    }
}

func.func @main() -> i32 {
    // Constants
    %ci0    = arith.constant 0 : index
    %ci1    = arith.constant 1 : index
    %c1     = arith.constant 1 : i32

    // Matrix Dimension
    %dim    = arith.constant 1024 : index
    // Grid Size
    %grd    = arith.constant 32 : index
    // Block Size
    %blk    = arith.constant 32 : index

    // initialize h_m0 on host
    %h_m0 = memref.alloc(%dim, %dim) : memref<2x?x?xi32>
    %h_c0 = memref.alloc(%dim, %dim) : memref<?x?xi32>
    scf.for %idx0 = %ci0 to %dim step %ci1 {
        scf.for %idx1 = %ci0 to %dim step %ci1 {
            memref.store %c1, %h_m0[%ci0, %idx0, %idx1] : memref<2x?x?xi32>
            memref.store %c1, %h_m0[%ci1, %idx0, %idx1] : memref<2x?x?xi32>
        }
    }
    %h_m0_unranked = memref.cast %h_m0 : memref<2x?x?xi32> to memref<*xi32>
    %h_c0_unranked = memref.cast %h_c0 : memref<?x?xi32> to memref<*xi32>
    gpu.host_register %h_m0_unranked : memref<*xi32>
    gpu.host_register %h_c0_unranked : memref<*xi32>

    // copy h_m0 to d_m0 on device.
    %t0, %d_m0 = async.execute () -> !async.value<memref<2x?x?xi32>> {
        %tmp_m0 = gpu.alloc(%dim, %dim) : memref<2x?x?xi32>
        gpu.memcpy %tmp_m0, %h_m0 : memref<2x?x?xi32>, memref<2x?x?xi32>
        async.yield %tmp_m0 : memref<2x?x?xi32>
    }
    // Allocate d_c0 on device
    //%t1, %d_c0 = gpu.alloc async (%dim, %dim) : memref<?x?xi32>
    %t1, %d_c0 = async.execute () -> !async.value<memref<?x?xi32>> {
        %tmp_c0 = gpu.alloc(%dim, %dim) : memref<?x?xi32>
        async.yield %tmp_c0 : memref<?x?xi32>
    }

    // Launch kernel function
    %t2 = async.execute [%t0, %t1] (
        %d_m0 as %in : !async.value<memref<2x?x?xi32>>,
        %d_c0 as %out : !async.value<memref<?x?xi32>>
    ) {
        gpu.launch_func @kernels::@kernel_matmul
            blocks in (%grd, %grd, %ci1)
            threads in (%blk, %blk, %ci1)
            args(%dim : index, %in : memref<2x?x?xi32>, %out : memref<?x?xi32>)
        async.yield
    }

    // Copy back result to h_c0
    %t3 = async.execute [%t2] (
        %d_c0 as %out : !async.value<memref<?x?xi32>>
    ) {
        gpu.memcpy %h_c0, %out : memref<?x?xi32>, memref<?x?xi32>
        async.yield
    }

    async.await %t3 : !async.token

    %sample = arith.constant 255 : index
    %ret = memref.load %h_c0[%ci1, %sample] : memref<?x?xi32>
    return %ret : i32
}

} // END gpu.container_module

// CHECK: 1024