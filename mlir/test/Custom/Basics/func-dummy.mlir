// RUN: mlir-opt %s -pass-pipeline="convert-func-to-llvm,reconcile-unrealized-casts" \
// RUN: | mlir-cpu-runner -e main -entry-point-result=i64 \
// RUN:   -shared-libs=%mlir_runner_utils_dir/libmlir_runner_utils%shlibext,%mlir_runner_utils_dir/libmlir_c_runner_utils%shlibext \
// RUN: | FileCheck %s

func.func @main() -> (i64) {
    %cst_0 = arith.constant 0 : i64
    func.return %cst_0 : i64
}

// CHECK: 0