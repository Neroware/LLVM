// RUN: mlir-vulkan-runner %s --shared-libs=%vulkan_wrapper_library_dir/libvulkan-runtime-wrappers%shlibext,%linalg_test_lib_dir/libmlir_runner_utils%shlibext --entry-point-result=i64 | FileCheck %s

module attributes {gpu.container_module, spv.target_env = #spv.target_env<#spv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_8bit_storage]>, #spv.resource_limits<>>} {
  gpu.module @kernels {
    gpu.func @kernel_1() kernel attributes {spv.entry_point_abi = #spv.entry_point_abi<local_size = dense<0> : vector<1xi32>>} {
      gpu.return
    }
  }
  func.func @main() -> i64 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c0_i64 = arith.constant 0 : i64
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c1 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %c42_i64 = arith.constant 42 : i64
    %2 = arith.addi %0, %c1 : index
    cf.br ^bb1(%2 : index)
  ^bb3:  // pred: ^bb1
    gpu.launch_func  @kernels::@kernel_1 blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1) 
    return %c0_i64 : i64
  }
}

// CHECK: 0