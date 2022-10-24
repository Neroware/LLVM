#!/usr/bin/python

import sys
import os
import re

BENCHMARK_API = """func.func private @_mlir_bm_zero_time() -> i64
func.func private @_mlir_bm_now() -> i64

func.func private @_mlir_bm_begin() -> i64
func.func private @_mlir_bm_end(i64) -> ()
func.func private @_mlir_bm_scope_next(i64) -> ()
func.func private @_mlir_bm_scope_end(i64) -> ()

func.func private @_mlir_bm_deltatime(i64) -> i64

func.func private @_mlir_bm_log_create() -> i64
func.func private @_mlir_bm_log_append(i64, i64, i64)
func.func private @_mlir_bm_log_store(i64) -> ()

"""

def run_mlir(mlir : str, build_dir : str, benchmark_dir : str):
    mlir_cpu_runner = build_dir + "bin/mlir-cpu-runner"
    mlir_opt = build_dir + "bin/mlir-opt"

    comm1 = mlir_opt + " " + mlir + " -pass-pipeline=\"convert-func-to-llvm,reconcile-unrealized-casts\" > " + mlir + ".llvm"
    os.system(comm1)

    comm2 = mlir_cpu_runner + " " + mlir + ".llvm -e main -entry-point-result=i64 -shared-libs=" + build_dir + "lib/libmlir_runner_utils.so," + build_dir + "lib/libmlir_c_runner_utils.so"
    os.system(comm2)

    comm3 = "rm " + benchmark_dir + "tmp.*"
    os.system(comm3)


def run_gpu_async_mlir(mlir : str, build_dir : str, benchmark_dir : str):
    mlir_cpu_runner = build_dir + "bin/mlir-cpu-runner"
    mlir_opt = build_dir + "bin/mlir-opt"

    comm1 = mlir_opt + " " + mlir + " -gpu-kernel-outlining -pass-pipeline='func.func(convert-scf-to-cf),gpu.module(strip-debuginfo,convert-scf-to-cf,convert-gpu-to-nvvm,gpu-to-cubin)' -gpu-async-region -gpu-to-llvm -async-to-async-runtime -async-runtime-ref-counting -convert-async-to-llvm -convert-func-to-llvm > " + mlir + ".llvm"
    os.system(comm1)

    comm2 = mlir_cpu_runner + " " + mlir + ".llvm -e main -entry-point-result=i64 -O0 -shared-libs=" + build_dir + "lib/libmlir_cuda_runtime.so," + build_dir + "lib/libmlir_async_runtime.so," + build_dir + "lib/libmlir_runner_utils.so," + build_dir + "lib/libmlir_c_runner_utils.so"
    os.system(comm2)

    comm3 = "rm " + benchmark_dir + "tmp.*"
    os.system(comm3)


def run_benchmark(build_dir : str, benchmark_dir : str):
    with open(benchmark_dir + "/mlir.txt", "r") as mlir:
        src : str = mlir.read()
    with open(benchmark_dir + "/gen.txt", "r") as listings:
        lines = listings.readlines()

    lines = [x.split(" ") for x in lines]
    for l_idx in range(len(lines)):
        line = lines[l_idx]
        if line[1] == "from" and line[3] == "to" and line[5] == "step":
            from_ = int(line[2])
            to_ = int(line[4])
            step_ = int(line[6])
            lines[l_idx] = [line[0]] + [str(x) for x in range(from_, to_ + 1, step_)]
    assert all([len(x) == len(lines[0]) for x in lines])

    for run in range(len(lines[0]) - 1):
        mlir_src = src
        for var in lines:
            pattern = "<" + var[0] + ">"
            value = var[1 + run]
            mlir_src = re.sub(pattern, str(value), mlir_src)
        insert_idx = mlir_src.find("func.func @main")
        mlir_src = mlir_src[:insert_idx] + BENCHMARK_API + mlir_src[insert_idx:]
        with open(benchmark_dir + "tmp.mlir", "w") as mlir:
            mlir.write(mlir_src)
        
        run_gpu_async_mlir(benchmark_dir + "tmp.mlir", build_dir, benchmark_dir)


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Please specify build directory and benchmark location!")
        print("run-benchmark.py <build-dir> <benchmark-dir>")
        exit(0)
    run_benchmark(sys.argv[1], sys.argv[2])