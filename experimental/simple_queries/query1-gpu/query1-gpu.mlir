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
    %csti_1023 = arith.constant 1023 : index
    %csti_1024 = arith.constant 1024 : index

    // Allocate relation R (a -> bc) in column store
    %a = memref.alloc() : memref<1024xi64>
    %b = memref.alloc() : memref<1024xi64>
    %c = memref.alloc() : memref<1024xi64>

    // Init relation R
    %counter = memref.alloc() : memref<i64>
    memref.store %cst_1, %counter[] : memref<i64>
    scf.for %idx0 = %csti_0 to %csti_1023 step %csti_1 {
        %iu_a = memref.load %counter[] : memref<i64>
        %b_tmp = memref.load %counter[] : memref<i64>
        %iu_b = arith.muli %b_tmp, %cst_2 : i64
        %c_tmp = memref.load %counter[] : memref<i64>
        %iu_c = arith.muli %c_tmp, %cst_4 : i64

        %counter_new = arith.addi %iu_a, %cst_1 : i64
        memref.store %counter_new, %counter[] : memref<i64>
        memref.store %iu_a, %a[%idx0] : memref<1024xi64>
        memref.store %iu_b, %b[%idx0] : memref<1024xi64>
        memref.store %iu_c, %c[%idx0] : memref<1024xi64>
    }

    // Allocate memory for result and initialize it to 0
    %out = memref.alloc() : memref<i64>
    memref.store %cst_0, %out[] : memref<i64>

    gpu.launch blocks(%bx, %by, %bz) in (%sz_bx = %csti_16, %sz_by = %csti_16, %sz_bz = %csti_1)
        threads(%tx, %ty, %tz) in (%sz_tx = %csti_16, %sz_ty = %csti_16, %sz_tz = %csti_1) 
    {
        %cst_42 = arith.constant 42 : i64
        %memref, %token = gpu.alloc async (%csti_1024) : memref<64x?xi64, 1>
        memref.store %iu_c, %c[%csti_0] : memref<1024xi64>
    }
    
    %ret = memref.load %out[] : memref<i64>
    return %ret : i64
}