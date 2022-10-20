// RUN: mlir-opt %s -pass-pipeline="convert-func-to-llvm,reconcile-unrealized-casts" \
// RUN: | mlir-cpu-runner -e main -entry-point-result=i64 \
// RUN:   -shared-libs=%mlir_runner_utils_dir/libmlir_runner_utils%shlibext,%mlir_runner_utils_dir/libmlir_c_runner_utils%shlibext \
// RUN: | FileCheck %s
func.func private @_mlir_ciface_nanoTime() -> i64
func.func private @printI64(%arg0 : i64)

func.func @main() -> (i64) {
    %c0 = arith.constant 0 : i64
    %ci0 = arith.constant 0 : index
    %ci1 = arith.constant 1 : index

    %time = func.call @_mlir_ciface_nanoTime() : () -> i64
    func.call @printI64(%time) : (i64) -> ()
    
    func.return %c0 : i64
}

// CHECK: 0