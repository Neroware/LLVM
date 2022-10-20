// Custom module containing runtime functions to provide additional
// support for benchmarking functionality

#include "mlir/ExecutionEngine/Benchmarking.h"

#include <cinttypes>
#include <chrono>

// NOLINTBEGIN(*-identifier-naming)

extern "C" int64_t mlirbm_zero_time() {
    return 0;
}

extern "C" int64_t mlirbm_now() {
  auto now = std::chrono::high_resolution_clock::now();
  auto duration = now.time_since_epoch();
  auto nanoseconds =
      std::chrono::duration_cast<std::chrono::nanoseconds>(duration);
  return nanoseconds.count();
}

// NOLINTEND(*-identifier-naming)