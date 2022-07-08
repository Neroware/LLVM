module attributes {gpu.container_module} {

  // This module creates a separate compilation unit for the GPU compiler.
  gpu.module @kernels {
    gpu.func @kernel_1(%arg0 : i64)
        kernel
        attributes {qux = "quux"} 
    {

      // Operations that produce block/thread IDs and dimensions are
      // injected when outlining the `gpu.launch` body to a function called
      // by `gpu.launch_func`.
      %tIdX = gpu.thread_id x
      %tIdY = gpu.thread_id y
      %tIdZ = gpu.thread_id z

      %bDimX = gpu.block_dim x
      %bDimY = gpu.block_dim y
      %bDimZ = gpu.block_dim z

      %bIdX = gpu.block_id x
      %bIdY = gpu.block_id y
      %bIdZ = gpu.block_id z

      %gDimX = gpu.grid_dim x
      %gDimY = gpu.grid_dim y
      %gDimZ = gpu.grid_dim z

      %cst_0 = arith.constant 0 : i64
      %true = arith.constant 1 : i1
      scf.if %true {
        
      }
      gpu.return
    }
  }

  %cst_0 = arith.constant 0 : i64
  %csti_1 = arith.constant 1 : index

  %t0 = gpu.wait async
  %foo = gpu.launch_func
      async                           // (Optional) Don't block host, return token.
      [%t0]                           // (Optional) Execute only after %t0 has completed.
      @kernels::@kernel_1             // Kernel function.
      blocks in (%csti_1, %csti_1, %csti_1)    // Grid size.
      threads in (%csti_1, %csti_1, %csti_1)   // Block size.
                                      // memory to allocate for a workgroup.
      args(%cst_0 : i64)              // (Optional) Kernel arguments.
}