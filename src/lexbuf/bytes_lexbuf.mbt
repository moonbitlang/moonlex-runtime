///|
pub(open) trait IBytesLexbuf {
  fn next_as_int(Self) -> Int32
  fn curr_pos(Self) -> Int32
  fn reset(Self, pos~ : Int32) -> Unit
  fn get_char(Self, Int32, Int32) -> Byte
  fn get_string(Self, Int32, Int32) -> BytesView
}

///|
pub struct BytesLexbuf {
  data : Bytes
  end : Int32
  mut pos : Int32
}

///|
pub fn BytesLexbuf::from_bytes(bytes : Bytes) -> BytesLexbuf {
  BytesLexbuf::{ data: bytes, end: bytes.length(), pos: 0, }
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
pub impl IBytesLexbuf for BytesLexbuf with fn reset(self, pos~ : Int32) {
  self.pos = pos
}

///|
pub impl IBytesLexbuf for BytesLexbuf with fn get_char(
  self,
  start : Int32,
  _end : Int32,
) {
  self.data[start]
}

///|
pub impl IBytesLexbuf for BytesLexbuf with fn get_string(
  self,
  start : Int32,
  end : Int32,
) {
  return self.data[start:end]
}

///|
pub extend BytesLexbuf with IBytesLexbuf::{
  next_as_int,
  curr_pos,
  reset,
  get_char,
  get_string,
}
