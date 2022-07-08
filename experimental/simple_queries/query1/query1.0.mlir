module {
  func.func @main() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(10 : i64) : i64
    %7 = llvm.mlir.constant(0 : index) : i64
    %8 = builtin.unrealized_conversion_cast %7 : i64 to index
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = builtin.unrealized_conversion_cast %9 : i64 to index
    %11 = llvm.mlir.constant(1023 : index) : i64
    %12 = builtin.unrealized_conversion_cast %11 : i64 to index
    %13 = memref.alloc() : memref<1024xi64>
    %14 = memref.alloc() : memref<1024xi64>
    %15 = memref.alloc() : memref<1024xi64>
    %16 = memref.alloc() : memref<i64>
    memref.store %1, %16[] : memref<i64>
    scf.for %arg0 = %8 to %12 step %10 {
      %19 = memref.load %16[] : memref<i64>
      %20 = memref.load %16[] : memref<i64>
      %21 = llvm.mul %20, %2  : i64
      %22 = memref.load %16[] : memref<i64>
      %23 = llvm.mul %22, %4  : i64
      %24 = llvm.add %19, %1  : i64
      memref.store %24, %16[] : memref<i64>
      memref.store %19, %13[%arg0] : memref<1024xi64>
      memref.store %21, %14[%arg0] : memref<1024xi64>
      memref.store %23, %15[%arg0] : memref<1024xi64>
    }
    %17 = memref.alloc() : memref<i64>
    memref.store %0, %17[] : memref<i64>
    scf.for %arg0 = %8 to %12 step %10 {
      %19 = memref.load %13[%arg0] : memref<1024xi64>
      %20 = memref.load %14[%arg0] : memref<1024xi64>
      %21 = memref.load %15[%arg0] : memref<1024xi64>
      %22 = llvm.add %20, %21  : i64
      %23 = llvm.icmp "ugt" %22, %6 : i64
      scf.if %23 {
        %24 = memref.load %17[] : memref<i64>
        %25 = llvm.add %24, %19  : i64
        memref.store %25, %17[] : memref<i64>
      }
    }
    %18 = memref.load %17[] : memref<i64>
    return %18 : i64
  }
}

