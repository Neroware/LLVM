module attributes {gpu.container_module} {
  %0 = llvm.mlir.constant(0 : i64) : i64
  %1 = llvm.mlir.constant(1 : index) : i64
  %2 = unrealized_conversion_cast %1 : i64 to index
  %3 = gpu.wait async
  %4 = gpu.launch_func async [%3] @kernels::@kernel_1 blocks in (%2, %2, %2) threads in (%2, %2, %2) args(%0 : i64)
}

