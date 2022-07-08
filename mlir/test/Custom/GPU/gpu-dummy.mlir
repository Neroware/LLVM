// RUN: mlir-vulkan-runner %s --shared-libs=%vulkan_wrapper_library_dir/libvulkan-runtime-wrappers%shlibext,%linalg_test_lib_dir/libmlir_runner_utils%shlibext --entry-point-result=i64 | FileCheck %s

module attributes {
  gpu.container_module,
  spv.target_env = #spv.target_env<
    #spv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_8bit_storage]>, #spv.resource_limits<>>
} {
  gpu.module @kernels {
    gpu.func @kernel_addi()
      kernel attributes { spv.entry_point_abi = #spv.entry_point_abi<local_size = dense<[0]>: vector<1xi32>>} {
      gpu.return
    }
  }

  func.func @main() -> i64 {
    %csti_1 = arith.constant 1 : index
    %cst_0 = arith.constant 0 : i64
    gpu.launch_func @kernels::@kernel_addi
        blocks in (%csti_1, %csti_1, %csti_1) threads in (%csti_1, %csti_1, %csti_1)
        args()
    return %cst_0 : i64
  }
} // END module

// CHECK: 0