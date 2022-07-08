module attributes {llvm.data_layout = ""} {
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @main() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(10 : i64) : i64
    %7 = llvm.mlir.constant(0 : index) : i64
    //%8 = builtin.unrealized_conversion_cast %7 : i64 to index
    %9 = llvm.mlir.constant(1 : index) : i64
    //%10 = builtin.unrealized_conversion_cast %9 : i64 to index
    %11 = llvm.mlir.constant(1023 : index) : i64
    //%12 = builtin.unrealized_conversion_cast %11 : i64 to index
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
    llvm.br ^bb1(%7 : i64)
  ^bb1(%67: i64):  // 2 preds: ^bb0, ^bb2
    //%68 = builtin.unrealized_conversion_cast %67 : i64 to index
    %69 = llvm.icmp "slt" %67, %11 : i64
    llvm.cond_br %69, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    //%70 = builtin.unrealized_conversion_cast %68 : index to i64
    %71 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %72 = llvm.load %71 : !llvm.ptr<i64>
    %73 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %74 = llvm.load %73 : !llvm.ptr<i64>
    %75 = llvm.mul %74, %2  : i64
    %76 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %77 = llvm.load %76 : !llvm.ptr<i64>
    %78 = llvm.mul %77, %4  : i64
    %79 = llvm.add %72, %1  : i64
    %80 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    llvm.store %79, %80 : !llvm.ptr<i64>
    %81 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %82 = llvm.getelementptr %81[%67] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %72, %82 : !llvm.ptr<i64>
    %83 = llvm.extractvalue %40[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %84 = llvm.getelementptr %83[%67] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %75, %84 : !llvm.ptr<i64>
    %85 = llvm.extractvalue %54[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %86 = llvm.getelementptr %85[%67] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %86 : !llvm.ptr<i64>
    %87 = llvm.add %67, %9  : i64
    llvm.br ^bb1(%87 : i64)
  ^bb3:  // pred: ^bb1
    %88 = llvm.mlir.constant(1 : index) : i64
    %89 = llvm.mlir.null : !llvm.ptr<i64>
    %90 = llvm.getelementptr %89[%88] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %91 = llvm.ptrtoint %90 : !llvm.ptr<i64> to i64
    %92 = llvm.call @malloc(%91) : (i64) -> !llvm.ptr<i8>
    %93 = llvm.bitcast %92 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %94 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %95 = llvm.insertvalue %93, %94[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %96 = llvm.insertvalue %93, %95[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %97 = llvm.mlir.constant(0 : index) : i64
    %98 = llvm.insertvalue %97, %96[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %99 = llvm.extractvalue %98[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    llvm.store %0, %99 : !llvm.ptr<i64>
    llvm.br ^bb4(%7 : i64)
  ^bb4(%100: i64):  // 2 preds: ^bb3, ^bb7
    //%101 = builtin.unrealized_conversion_cast %100 : i64 to index
    %102 = llvm.icmp "slt" %100, %11 : i64
    llvm.cond_br %102, ^bb5, ^bb8
  ^bb5:  // pred: ^bb4
    //%103 = builtin.unrealized_conversion_cast %101 : index to i64
    %104 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %105 = llvm.getelementptr %104[%100] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %106 = llvm.load %105 : !llvm.ptr<i64>
    %107 = llvm.extractvalue %40[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%100] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %109 = llvm.load %108 : !llvm.ptr<i64>
    %110 = llvm.extractvalue %54[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %111 = llvm.getelementptr %110[%100] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %112 = llvm.load %111 : !llvm.ptr<i64>
    %113 = llvm.add %109, %112  : i64
    %114 = llvm.icmp "ugt" %113, %6 : i64
    llvm.cond_br %114, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %115 = llvm.extractvalue %98[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %116 = llvm.load %115 : !llvm.ptr<i64>
    %117 = llvm.add %116, %106  : i64
    %118 = llvm.extractvalue %98[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    llvm.store %117, %118 : !llvm.ptr<i64>
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    %119 = llvm.add %100, %9  : i64
    llvm.br ^bb4(%119 : i64)
  ^bb8:  // pred: ^bb4
    %120 = llvm.extractvalue %98[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %121 = llvm.load %120 : !llvm.ptr<i64>
    llvm.return %121 : i64
  }
}

