// RUN: mlir-vulkan-runner %s --shared-libs=%vulkan_wrapper_library_dir/libvulkan-runtime-wrappers%shlibext,%linalg_test_lib_dir/libmlir_runner_utils%shlibext --entry-point-result=i32 | FileCheck %s

module attributes {
    gpu.container_module,
    spv.target_env = #spv.target_env<
        #spv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_8bit_storage]>, #spv.resource_limits<>>
} {

gpu.module @kernels {
    gpu.func @kernel_1(%ptr : memref<1xi32>)
        kernel attributes { spv.entry_point_abi = #spv.entry_point_abi<local_size = dense<[1]>: vector<1xi32>>} {
        %csti_0 = arith.constant 0 : index
        %cst_1 = arith.constant 1 : i32

        %tmp = memref.load %ptr[%csti_0] : memref<1xi32>
        %x = arith.addi %tmp, %cst_1 : i32
        memref.store %x, %ptr[%csti_0] : memref<1xi32>

        gpu.return
    }
}

func.func @main() -> i32 {
    %csti_0 = arith.constant 0 : index
    %csti_32 = arith.constant 32 : index
    %cst_0 = arith.constant 0 : i32

    %out = memref.alloc() : memref<1xi32>
    memref.store %cst_0, %out[%csti_0] : memref<1xi32>

    gpu.launch_func @kernels::@kernel_1
        blocks in (%csti_32, %csti_32, %csti_32) threads in (%csti_32, %csti_32, %csti_32)
        args(%out : memref<1xi32>)
    
    %ret = memref.load %out[%csti_0] : memref<1xi32>
    return %ret : i32
}

} // End module

// CHECK: 1073741824