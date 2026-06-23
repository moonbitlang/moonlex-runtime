///|
pub(open) trait IBytesLexbuf {
  fn next_as_int(Self) -> Int
  fn curr_pos(Self) -> Int
  fn reset(Self, pos~ : Int) -> Unit
  fn get_char(Self, Int, Int) -> Byte
  fn get_string(Self, Int, Int) -> BytesView
}

///|
pub struct BytesLexbuf {
  data : Bytes
  end : Int
  mut pos : Int
}

///|
pub fn BytesLexbuf::from_bytes(bytes : Bytes) -> BytesLexbuf {
  BytesLexbuf::{ data: bytes, end: bytes.length(), pos: 0 }
}

///|
pub impl IBytesLexbuf for BytesLexbuf with fn next_as_int(self) {
  if self.pos >= self.end {
    return -1
  }
  let byte = self.data[self.pos]
  self.pos += 1
  return byte.to_int()
}

///|
pub impl IBytesLexbuf for BytesLexbuf with fn curr_pos(self) {
  return self.pos
}

///|
pub impl IBytesLexbuf for BytesLexbuf with fn reset(self, pos~ : Int) {
  self.pos = pos
}

///|
pub impl IBytesLexbuf for BytesLexbuf with fn get_char(
  self,
  start : Int,
  _end : Int,
) {
  self.data[start]
}

///|
pub impl IBytesLexbuf for BytesLexbuf with fn get_string(
  self,
  start : Int,
  end : Int,
) {
  return self.data[start:end]
}
