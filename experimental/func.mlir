func.func @identity(%x : i32) -> (i32) {
  func.return %x : i32
}

//%func = func.constant @identity : (i32) -> i32