module {
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
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
    %13 = llvm.mlir.constant(1024 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.null : !llvm.ptr<i64>
    %16 = llvm.getelementptr %15[%13] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %17 = llvm.ptrtoint %16 : !llvm.ptr<i64> to i64
    %18 = llvm.call @malloc(%17) : (i64) -> !llvm.ptr<i8>
    %19 = llvm.bitcast %18 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %20 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %21 = llvm.insertvalue %19, %20[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %22 = llvm.insertvalue %19, %21[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %23 = llvm.mlir.constant(0 : index) : i64
    %24 = llvm.insertvalue %23, %22[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %25 = llvm.insertvalue %13, %24[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %14, %25[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.mlir.constant(1024 : index) : i64
    %28 = llvm.mlir.constant(1 : index) : i64
    %29 = llvm.mlir.null : !llvm.ptr<i64>
    %30 = llvm.getelementptr %29[%27] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %31 = llvm.ptrtoint %30 : !llvm.ptr<i64> to i64
    %32 = llvm.call @malloc(%31) : (i64) -> !llvm.ptr<i8>
    %33 = llvm.bitcast %32 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %34 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %35 = llvm.insertvalue %33, %34[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.insertvalue %33, %35[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %37 = llvm.mlir.constant(0 : index) : i64
    %38 = llvm.insertvalue %37, %36[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %39 = llvm.insertvalue %27, %38[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %40 = llvm.insertvalue %28, %39[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %41 = llvm.mlir.constant(1024 : index) : i64
    %42 = llvm.mlir.constant(1 : index) : i64
    %43 = llvm.mlir.null : !llvm.ptr<i64>
    %44 = llvm.getelementptr %43[%41] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %45 = llvm.ptrtoint %44 : !llvm.ptr<i64> to i64
    %46 = llvm.call @malloc(%45) : (i64) -> !llvm.ptr<i8>
    %47 = llvm.bitcast %46 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %48 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.insertvalue %47, %48[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %50 = llvm.insertvalue %47, %49[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.mlir.constant(0 : index) : i64
    %52 = llvm.insertvalue %51, %50[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.insertvalue %41, %52[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.insertvalue %42, %53[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %55 = llvm.mlir.constant(1 : index) : i64
    %56 = llvm.mlir.null : !llvm.ptr<i64>
    %57 = llvm.getelementptr %56[%55] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %58 = llvm.ptrtoint %57 : !llvm.ptr<i64> to i64
    %59 = llvm.call @malloc(%58) : (i64) -> !llvm.ptr<i8>
    %60 = llvm.bitcast %59 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %61 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %62 = llvm.insertvalue %60, %61[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %63 = llvm.insertvalue %60, %62[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %64 = llvm.mlir.constant(0 : index) : i64
    %65 = llvm.insertvalue %64, %63[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %66 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    llvm.store %1, %66 : !llvm.ptr<i64>
    cf.br ^bb1(%8 : index)
  ^bb1(%67: index):  // 2 preds: ^bb0, ^bb2
    %68 = arith.cmpi slt, %67, %12 : index
    cf.cond_br %68, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %69 = builtin.unrealized_conversion_cast %67 : index to i64
    %70 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %71 = llvm.load %70 : !llvm.ptr<i64>
    %72 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %73 = llvm.load %72 : !llvm.ptr<i64>
    %74 = llvm.mul %73, %2  : i64
    %75 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %76 = llvm.load %75 : !llvm.ptr<i64>
    %77 = llvm.mul %76, %4  : i64
    %78 = llvm.add %71, %1  : i64
    %79 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    llvm.store %78, %79 : !llvm.ptr<i64>
    %80 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%69] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %71, %81 : !llvm.ptr<i64>
    %82 = llvm.extractvalue %40[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %83 = llvm.getelementptr %82[%69] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %74, %83 : !llvm.ptr<i64>
    %84 = llvm.extractvalue %54[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%69] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %77, %85 : !llvm.ptr<i64>
    %86 = arith.addi %67, %10 : index
    cf.br ^bb1(%86 : index)
  ^bb3:  // pred: ^bb1
    %87 = llvm.mlir.constant(1 : index) : i64
    %88 = llvm.mlir.null : !llvm.ptr<i64>
    %89 = llvm.getelementptr %88[%87] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %90 = llvm.ptrtoint %89 : !llvm.ptr<i64> to i64
    %91 = llvm.call @malloc(%90) : (i64) -> !llvm.ptr<i8>
    %92 = llvm.bitcast %91 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %93 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %94 = llvm.insertvalue %92, %93[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %95 = llvm.insertvalue %92, %94[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %96 = llvm.mlir.constant(0 : index) : i64
    %97 = llvm.insertvalue %96, %95[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %98 = llvm.extractvalue %97[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    llvm.store %0, %98 : !llvm.ptr<i64>
    cf.br ^bb4(%8 : index)
  ^bb4(%99: index):  // 2 preds: ^bb3, ^bb7
    %100 = arith.cmpi slt, %99, %12 : index
    cf.cond_br %100, ^bb5, ^bb8
  ^bb5:  // pred: ^bb4
    %101 = builtin.unrealized_conversion_cast %99 : index to i64
    %102 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%101] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %104 = llvm.load %103 : !llvm.ptr<i64>
    %105 = llvm.extractvalue %40[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%101] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %107 = llvm.load %106 : !llvm.ptr<i64>
    %108 = llvm.extractvalue %54[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %109 = llvm.getelementptr %108[%101] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %110 = llvm.load %109 : !llvm.ptr<i64>
    %111 = llvm.add %107, %110  : i64
    %112 = llvm.icmp "ugt" %111, %6 : i64
    cf.cond_br %112, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %113 = llvm.extractvalue %97[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %114 = llvm.load %113 : !llvm.ptr<i64>
    %115 = llvm.add %114, %104  : i64
    %116 = llvm.extractvalue %97[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    llvm.store %115, %116 : !llvm.ptr<i64>
    cf.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    %117 = arith.addi %99, %10 : index
    cf.br ^bb4(%117 : index)
  ^bb8:  // pred: ^bb4
    %118 = llvm.extractvalue %97[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %119 = llvm.load %118 : !llvm.ptr<i64>
    return %119 : i64
  }
}

