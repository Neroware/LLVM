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

// select sum(a) 
// from R 
// where b + c > 10

module attributes {gpu.container_module} {

gpu.module @kernels {
    gpu.func @select_sum(
        %r_size : index, 
        %tup_per_thr : index,
        %in_a : memref<?xi32>,
        %in_b : memref<?xi32>,
        %in_c : memref<?xi32>,
        %out : memref<?xi32>
    ) kernel attributes {spv.entry_point_abi = #spv.entry_point_abi<local_size = dense<[1, 1, 1]>: vector<3xi32>>} {

        // Constants
        %ci0    = arith.constant 0 : index
        %ci1    = arith.constant 1 : index
        %c0     = arith.constant 0 : i32
        %c1     = arith.constant 1 : i32
        %c10    = arith.constant 10 : i32

        %tId = gpu.thread_id x
        %bDim = gpu.block_dim x
        %bId = gpu.block_id x

        // Kernel Index
        %kIdtmp = arith.muli %bId, %bDim : index
        %kId = arith.addi %kIdtmp, %tId : index

        // Initialize partial aggregate to zero
        memref.store %c0, %out[%kId] : memref<?xi32>

        // Iterate over tuples
        %start = arith.muli %kId, %tup_per_thr : index
        %end = arith.addi %start, %tup_per_thr : index
        scf.for %idx0 = %start to %end step %ci1 {
            %idx_cmp = arith.cmpi "ult", %idx0, %r_size : index
            scf.if %idx_cmp {
                // Selection b + c > 10
                %iu_b = memref.load %in_b[%idx0] : memref<?xi32>
                %iu_c = memref.load %in_c[%idx0] : memref<?xi32>
                %sum_cb = arith.addi %iu_b, %iu_c : i32
                %sel = arith.cmpi "sgt", %sum_cb, %c10 : i32
                scf.if %sel {
                    %iu_a = memref.load %in_a[%idx0] : memref<?xi32>
                    %tmp0 = memref.load %out[%kId] : memref<?xi32>
                    %tmp1 = arith.addi %tmp0, %iu_a : i32
                    memref.store %tmp1, %out[%kId] : memref<?xi32>
                }   
            }
        }

        gpu.return
    }
}

func.func @main() -> i32 {
    // Constants
    %ci0    = arith.constant 0 : index
    %ci1    = arith.constant 1 : index
    %c0     = arith.constant 0 : i32
    %c1     = arith.constant 1 : i32
    %c2     = arith.constant 2 : i32
    %c4     = arith.constant 4 : i32
    // Relation Size
    %size   = arith.constant 50000 : index
    // Block Size
    %blk    = arith.constant 100 : index
    // Tuples per thread
    %tup    = arith.constant 100 : index

    // Compute grid size from block size and tuples per thread
    %blk_tup = arith.muli %blk, %tup : index
    %grd_tmp0 = arith.divui %size, %blk_tup : index
    %grd_tmp1 = arith.muli %grd_tmp0, %blk_tup : index
    %grd_tmp2 = arith.subi %size, %grd_tmp1 : index
    %grd_cmp = arith.cmpi "ne", %grd_tmp2, %ci0 : index
    %grd0 = memref.alloc() : memref<index>
    memref.store %grd_tmp0, %grd0[] : memref<index>
    scf.if %grd_cmp {
        %grd_tmp3 = arith.addi %grd_tmp0, %ci1 : index
        memref.store %grd_tmp3, %grd0[] : memref<index>
    }
    %grd = memref.load %grd0[] : memref<index>
    %naggr = arith.muli %grd, %blk : index

    // Allocate relation R (a -> bc) in column store
    // Init relation R on host
    %a = memref.alloc(%size) : memref<?xi32>
    %b = memref.alloc(%size) : memref<?xi32>
    %c = memref.alloc(%size) : memref<?xi32>
    %counter = memref.alloc() : memref<i32>
    memref.store %c0, %counter[] : memref<i32>
    scf.for %idx0 = %ci0 to %size step %ci1 {
        %iu_a = memref.load %counter[] : memref<i32>
        %b_tmp = memref.load %counter[] : memref<i32>
        %iu_b = arith.muli %b_tmp, %c2 : i32
        %c_tmp = memref.load %counter[] : memref<i32>
        %iu_c = arith.muli %c_tmp, %c4 : i32

        %counter_new = arith.addi %iu_a, %c1 : i32
        memref.store %counter_new, %counter[] : memref<i32>
        memref.store %iu_a, %a[%idx0] : memref<?xi32>
        memref.store %iu_b, %b[%idx0] : memref<?xi32>
        memref.store %iu_c, %c[%idx0] : memref<?xi32>
    }
    %h_out = memref.alloc(%naggr) : memref<?xi32>

    // Register host memory
    %a_unranked = memref.cast %a : memref<?xi32> to memref<*xi32>
    %b_unranked = memref.cast %b : memref<?xi32> to memref<*xi32>
    %c_unranked = memref.cast %c : memref<?xi32> to memref<*xi32>
    %h_out_unranked = memref.cast %h_out : memref<?xi32> to memref<*xi32>
    gpu.host_register %a_unranked : memref<*xi32>
    gpu.host_register %b_unranked : memref<*xi32>
    gpu.host_register %c_unranked : memref<*xi32>
    gpu.host_register %h_out_unranked : memref<*xi32>

    // copy a to d_a on device.
    %t_a0, %d_a = async.execute () -> !async.value<memref<?xi32>> {
        %tmp_a = gpu.alloc(%size) : memref<?xi32>
        gpu.memcpy %tmp_a, %a : memref<?xi32>, memref<?xi32>
        async.yield %tmp_a : memref<?xi32>
    }
    // copy b to d_b on device.
    %t_b0, %d_b = async.execute () -> !async.value<memref<?xi32>> {
        %tmp_b = gpu.alloc(%size) : memref<?xi32>
        gpu.memcpy %tmp_b, %b : memref<?xi32>, memref<?xi32>
        async.yield %tmp_b : memref<?xi32>
    }
    // copy c to d_c on device.
    %t_c0, %d_c = async.execute () -> !async.value<memref<?xi32>> {
        %tmp_c = gpu.alloc(%size) : memref<?xi32>
        gpu.memcpy %tmp_c, %c : memref<?xi32>, memref<?xi32>
        async.yield %tmp_c : memref<?xi32>
    }
    // Allocate memory for partial aggregates on device
    %t_out0, %d_out = async.execute () -> !async.value<memref<?xi32>> {
        %tmp_out0 = gpu.alloc(%naggr) : memref<?xi32>
        async.yield %tmp_out0 : memref<?xi32>
    }

    // Launch kernel function
    %t_out1 = async.execute [%t_a0, %t_b0, %t_c0, %t_out0] (
        %d_a as %in_a : !async.value<memref<?xi32>>,
        %d_b as %in_b : !async.value<memref<?xi32>>,
        %d_c as %in_c : !async.value<memref<?xi32>>,
        %d_out as %out : !async.value<memref<?xi32>>
    ) {
        gpu.launch_func @kernels::@select_sum
            blocks in (%grd, %ci1, %ci1)
            threads in (%blk, %ci1, %ci1)
            args(
                %size : index,
                %tup : index,
                %in_a : memref<?xi32>,
                %in_b : memref<?xi32>,
                %in_c : memref<?xi32>,
                %out : memref<?xi32>
            )
        async.yield
    }

    // Copy back partial aggregates to h_out
    %t_out2 = async.execute [%t_out1] (
        %d_out as %out : !async.value<memref<?xi32>>
    ) {
        gpu.memcpy %h_out, %out : memref<?xi32>, memref<?xi32>
        async.yield
    }

    async.await %t_out2 : !async.token

    // Sum up partial ggregates
    %ret0 = memref.alloc() : memref<i32>
    memref.store %c0, %ret0[] : memref<i32>
    scf.for %idx = %ci0 to %naggr step %ci1 {
        %tmp0 = memref.load %ret0[] : memref<i32>
        %tmp1 = memref.load %h_out[%idx] : memref<?xi32>
        %tmp2 = arith.addi %tmp0, %tmp1 : i32
        memref.store %tmp2, %ret0[] : memref<i32>
    }

    // Load and return query result
    %ret = memref.load %ret0[] : memref<i32>
    return %ret : i32
} 

} // END gpu.container_module

// CHECK: 1249974999