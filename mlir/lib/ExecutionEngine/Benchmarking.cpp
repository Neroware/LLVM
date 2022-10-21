// Custom module containing runtime functions to provide additional
// support for benchmarking functionality

#include "mlir/ExecutionEngine/Benchmarking.h"

#include <cinttypes>
#include <chrono>

// NOLINTBEGIN(*-identifier-naming)

extern "C" int64_t _mlir_bm_zero_time() {
    return 0;
}

extern "C" int64_t _mlir_bm_now() {
  auto now = std::chrono::high_resolution_clock::now();
  auto duration = now.time_since_epoch();
  auto nanoseconds =
      std::chrono::duration_cast<std::chrono::nanoseconds>(duration);
  return nanoseconds.count();
}

extern "C" int64_t _mlir_bm_begin() {
  auto scope = new mlirbm::time_measurement_scope();
  scope->start = _mlir_bm_now();
  scope->depth = 0;
  scope->scope = nullptr;
  return reinterpret_cast<int64_t>(scope);
}

extern "C" void _mlir_bm_end(int64_t scope_) {
  auto scope = reinterpret_cast<mlirbm::time_measurement_scope*>(scope_);
  delete(scope);
}

extern "C" int64_t _mlir_bm_next_scope(int64_t scope_) {
  auto scope = reinterpret_cast<mlirbm::time_measurement_scope*>(scope_);
  auto next = new mlirbm::time_measurement_scope();
  next->start = _mlir_bm_now();
  next->depth = scope->depth + 1;
  next->scope = scope;
  return reinterpret_cast<int64_t>(next);
}

extern "C" int64_t _mlir_bm_scope_end(int64_t scope_) {
  auto scope = reinterpret_cast<mlirbm::time_measurement_scope*>(scope_);
  auto prev = scope->scope;
  delete(scope);
  return reinterpret_cast<int64_t>(prev);
}

extern "C" int64_t _mlir_bm_deltatime(int64_t scope_) {
  auto scope = reinterpret_cast<mlirbm::time_measurement_scope*>(scope_);
  auto now = _mlir_bm_now();
  return now - scope->start;
}

//extern "C" void _mlir_bm_log_result(int64_t dt)

// NOLINTEND(*-identifier-naming)