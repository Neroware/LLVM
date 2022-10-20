// RUN: mlir-opt %s -pass-pipeline="convert-func-to-llvm,reconcile-unrealized-casts" \
// RUN: | mlir-cpu-runner -e main -entry-point-result=i64 \
// RUN:   -shared-libs=%mlir_runner_utils_dir/libmlir_runner_utils%shlibext,%mlir_runner_utils_dir/libmlir_c_runner_utils%shlibext \
// RUN: | FileCheck %s
func.func private @mlirbm_zero_time() -> i64

func.func @main() -> (i64) {
    %zerotime = func.call @mlirbm_zero_time() : () -> i64
   
    func.return %zerotime : i64
}

// CHECK: 0