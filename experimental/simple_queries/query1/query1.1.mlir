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
    scf.for %arg0 = %8 to %12 step %10 {
      %81 = builtin.unrealized_conversion_cast %arg0 : index to i64
      %82 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
      %83 = llvm.load %82 : !llvm.ptr<i64>
      %84 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
      %85 = llvm.load %84 : !llvm.ptr<i64>
      %86 = llvm.mul %85, %2  : i64
      %87 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
      %88 = llvm.load %87 : !llvm.ptr<i64>
      %89 = llvm.mul %88, %4  : i64
      %90 = llvm.add %83, %1  : i64
      %91 = llvm.extractvalue %65[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
      llvm.store %90, %91 : !llvm.ptr<i64>
      %92 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
      %93 = llvm.getelementptr %92[%81] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
      llvm.store %83, %93 : !llvm.ptr<i64>
      %94 = llvm.extractvalue %40[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
      %95 = llvm.getelementptr %94[%81] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
      llvm.store %86, %95 : !llvm.ptr<i64>
      %96 = llvm.extractvalue %54[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
      %97 = llvm.getelementptr %96[%81] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
      llvm.store %89, %97 : !llvm.ptr<i64>
    }
    %67 = llvm.mlir.constant(1 : index) : i64
    %68 = llvm.mlir.null : !llvm.ptr<i64>
    %69 = llvm.getelementptr %68[%67] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %70 = llvm.ptrtoint %69 : !llvm.ptr<i64> to i64
    %71 = llvm.call @malloc(%70) : (i64) -> !llvm.ptr<i8>
    %72 = llvm.bitcast %71 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %73 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %74 = llvm.insertvalue %72, %73[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %75 = llvm.insertvalue %72, %74[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %76 = llvm.mlir.constant(0 : index) : i64
    %77 = llvm.insertvalue %76, %75[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %78 = llvm.extractvalue %77[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    llvm.store %0, %78 : !llvm.ptr<i64>
    scf.for %arg0 = %8 to %12 step %10 {
      %81 = builtin.unrealized_conversion_cast %arg0 : index to i64
      %82 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
      %83 = llvm.getelementptr %82[%81] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
      %84 = llvm.load %83 : !llvm.ptr<i64>
      %85 = llvm.extractvalue %40[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
      %86 = llvm.getelementptr %85[%81] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
      %87 = llvm.load %86 : !llvm.ptr<i64>
      %88 = llvm.extractvalue %54[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
      %89 = llvm.getelementptr %88[%81] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
      %90 = llvm.load %89 : !llvm.ptr<i64>
      %91 = llvm.add %87, %90  : i64
      %92 = llvm.icmp "ugt" %91, %6 : i64
      scf.if %92 {
        %93 = llvm.extractvalue %77[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
        %94 = llvm.load %93 : !llvm.ptr<i64>
        %95 = llvm.add %94, %84  : i64
        %96 = llvm.extractvalue %77[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
        llvm.store %95, %96 : !llvm.ptr<i64>
      }
    }
    %79 = llvm.extractvalue %77[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %80 = llvm.load %79 : !llvm.ptr<i64>
    return %80 : i64
  }
}

