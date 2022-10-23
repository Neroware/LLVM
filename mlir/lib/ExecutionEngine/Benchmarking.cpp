// Custom module containing runtime functions to provide additional
// support for benchmarking functionality

#include "mlir/ExecutionEngine/Benchmarking.h"

#include <cinttypes>
#include <chrono>
#include <unordered_map>
#include <fstream>
#include <string>
#include <iomanip>

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
  auto tm = new mlirbm::time_measurement();
  tm->scope = nullptr;
  return reinterpret_cast<int64_t>(tm);
}

extern "C" void _mlir_bm_end(int64_t scope) {
  delete(reinterpret_cast<mlirbm::time_measurement*>(scope));
}

extern "C" void _mlir_bm_scope_next(int64_t scope) {
  auto tm = reinterpret_cast<mlirbm::time_measurement*>(scope);
  auto next = new mlirbm::time_measurement_scope();
  next->scope = tm->scope;
  tm->scope = next;
  next->start = _mlir_bm_now();
}

extern "C" void _mlir_bm_scope_end(int64_t scope) {
  auto tm = reinterpret_cast<mlirbm::time_measurement*>(scope);
  auto prev = tm->scope;
  tm->scope = prev->scope;
  delete(prev);
}

extern "C" int64_t _mlir_bm_deltatime(int64_t scope) {
  auto now = _mlir_bm_now();
  auto tm = reinterpret_cast<mlirbm::time_measurement*>(scope);
  return now - tm->scope->start;
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
  std::fstream logfile;
  logfile.open("../../experimental/benchmarks/result.log", std::ios::app);
  if (logfile.is_open()) {
    for (auto& it : log->data) {
      logfile << it.first << ":" << std::setprecision(3) << (it.second / 1000000.0) << "ms ";
    }
    logfile << std::endl;
  }
  logfile.close();

  delete(log);
}

// NOLINTEND(*-identifier-naming)