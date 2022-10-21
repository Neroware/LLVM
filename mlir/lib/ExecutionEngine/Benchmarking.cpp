// Custom module containing runtime functions to provide additional
// support for benchmarking functionality

#include "mlir/ExecutionEngine/Benchmarking.h"

#include <cinttypes>
#include <chrono>
#include <unordered_map>
#include <fstream>
#include <string>

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
  auto scope_ = reinterpret_cast<int64_t>(scope);
  scope->depth = 0;
  scope->scope = nullptr;
  scope->start = _mlir_bm_now();
  return scope_;
}

extern "C" void _mlir_bm_end(int64_t scope_) {
  delete(reinterpret_cast<mlirbm::time_measurement_scope*>(scope_));
}

extern "C" int64_t _mlir_bm_next_scope(int64_t scope_) {
  auto scope = reinterpret_cast<mlirbm::time_measurement_scope*>(scope_);
  auto next = new mlirbm::time_measurement_scope();
  auto next_ = reinterpret_cast<int64_t>(next);
  next->depth = scope->depth + 1;
  next->scope = scope;
  next->start = _mlir_bm_now();
  return next_;
}

extern "C" int64_t _mlir_bm_scope_end(int64_t scope_) {
  auto scope = reinterpret_cast<mlirbm::time_measurement_scope*>(scope_);
  auto prev = scope->scope;
  delete(scope);
  return reinterpret_cast<int64_t>(prev);
}

extern "C" int64_t _mlir_bm_deltatime(int64_t scope_) {
  auto now = _mlir_bm_now();
  auto scope = reinterpret_cast<mlirbm::time_measurement_scope*>(scope_);
  return now - scope->start;
}

extern "C" int64_t _mlir_bm_log_create() {
  auto log = new mlirbm::time_measurement_log();
  return reinterpret_cast<int64_t>(log);
}

extern "C" void _mlir_bm_log_append(int64_t log_, int64_t measure_id, int64_t time_ns) {
  auto log = reinterpret_cast<mlirbm::time_measurement_log*>(log_);
  log->data[measure_id] = time_ns;
}

extern "C" void _mlir_bm_log_store(int64_t log_) {
  auto log = reinterpret_cast<mlirbm::time_measurement_log*>(log_);
  std::string output = "";
  for (auto& it : log->data) {
    output += std::to_string(it.first) + ":" + std::to_string(it.second) + "ns ";
  }

  std::fstream logfile;
  logfile.open("../../experimental/benchmarks/result.log", std::ios::app);
  if (logfile.is_open()) {
    logfile << output << std::endl;
  }
  logfile.close();

  delete(log);
}

// NOLINTEND(*-identifier-naming)