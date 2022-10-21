// Custom module containing runtime functions to provide additional
// support for benchmarking functionality

#ifndef MLIR_EXECUTIONENGINE_BENCHMARKING_H_
#define MLIR_EXECUTIONENGINE_BENCHMARKING_H_

#include "mlir/ExecutionEngine/RunnerUtils.h"

namespace mlirbm{

struct time_measurement_scope{
    time_measurement_scope* scope;
    int64_t depth;
    int64_t start;
};

} // END mlirbm

////////////////////////////////////////////////////////////////////////////////
// Currently exposed C API.
////////////////////////////////////////////////////////////////////////////////

extern "C" MLIR_RUNNERUTILS_EXPORT int64_t _mlir_bm_zero_time();
extern "C" MLIR_RUNNERUTILS_EXPORT int64_t _mlir_bm_now();

extern "C" MLIR_RUNNERUTILS_EXPORT int64_t _mlir_bm_begin();
extern "C" MLIR_RUNNERUTILS_EXPORT void _mlir_bm_end(int64_t scope);
extern "C" MLIR_RUNNERUTILS_EXPORT int64_t _mlir_bm_scope_next(int64_t scope);
extern "C" MLIR_RUNNERUTILS_EXPORT int64_t _mlir_bm_scope_end(int64_t scope);

extern "C" MLIR_RUNNERUTILS_EXPORT int64_t _mlir_bm_deltatime(int64_t scope);

#endif // MLIR_EXECUTIONENGINE_BENCHMARKING_H_