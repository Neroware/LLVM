module attributes {gpu.container_module} {

gpu.module @kernels {
    gpu.func @kernel_1(%arg0: index)
    //workgroup(%workgroup: memref<32xf32, 3>)
    //private(%private: memref<1xf32, 5>)
    kernel
    attributes {qux = "quux"} 
    {
        gpu.return
    }
}

func.func @main() -> i64 {
    // Constants
    %cst_0 = arith.constant 0 : i64
    %csti_1 = arith.constant 1 : index

    %t0 = gpu.wait async
    %foo = gpu.launch_func
        async
        [%t0]
        @kernels::@kernel_1
        blocks in (%csti_1, %csti_1, %csti_1)
        threads in (%csti_1, %csti_1, %csti_1)
        args(%csti_1 : index)

    return %cst_0 : i64
}

} // END module