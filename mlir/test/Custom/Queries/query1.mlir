// RUN: mlir-opt %s -pass-pipeline="func.func(convert-linalg-to-loops,convert-scf-to-cf,convert-arith-to-llvm),convert-linalg-to-llvm,convert-memref-to-llvm,convert-func-to-llvm,reconcile-unrealized-casts" \
// RUN: | mlir-cpu-runner -e main -entry-point-result=i64 \
// RUN:   -shared-libs=%mlir_runner_utils_dir/libmlir_runner_utils%shlibext,%mlir_runner_utils_dir/libmlir_c_runner_utils%shlibext \
// RUN: | FileCheck %s

// select sum(a) 
// from R 
// where b + c > 10

func.func @main() -> i64 {
    // Constants
    %cst_0 = arith.constant 0 : i64
    %cst_1 = arith.constant 1 : i64
    %cst_2 = arith.constant 2 : i64
    %cst_3 = arith.constant 3 : i64
    %cst_4 = arith.constant 4 : i64
    %cst_5 = arith.constant 5 : i64
    %cst_10 = arith.constant 10 : i64
    %cst_1023 = arith.constant 1023 : i64
    
    %csti_0 = arith.index_cast %cst_0 : i64 to index
    %csti_1 = arith.index_cast %cst_1 : i64 to index
    %csti_1023 = arith.index_cast %cst_1023 : i64 to index

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

    // Loop for sum
    scf.for %idx0 = %csti_0 to %csti_1023 step %csti_1 {
        // Load information units
        %iu_a = memref.load %a[%idx0] : memref<1024xi64>
        %iu_b = memref.load %b[%idx0] : memref<1024xi64>
        %iu_c = memref.load %c[%idx0] : memref<1024xi64>

        // Selection b + c > 10
        %tmp1 = arith.addi %iu_b, %iu_c : i64
        %tmp2 = arith.cmpi "ugt", %tmp1, %cst_10 : i64
        scf.if %tmp2 {
            %n = memref.load %out[] : memref<i64>
            %tmp = arith.addi %n, %iu_a : i64
            memref.store %tmp, %out[] : memref<i64>
        }
    }

    %ret = memref.load %out[] : memref<i64>
    return %ret : i64
}

// CHECK: 523775