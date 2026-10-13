///|
pub(open) trait IStringLexbuf {
  fn next_as_int(Self) -> Int32
  fn curr_pos(Self) -> Int32
  fn reset(Self, pos~ : Int32) -> Unit
  fn get_char(Self, Int32, Int32) -> Char
  fn get_string(Self, Int32, Int32) -> String
}

///|
pub struct StringLexbuf {
  data : String
  end : Int32
  mut pos : Int32
}

///|
pub fn StringLexbuf::from_string(string : String) -> StringLexbuf {
  StringLexbuf::{ data: string, end: string.length(), pos: 0, }
}

///|
pub impl IStringLexbuf for StringLexbuf with fn next_as_int(self) {
  let pos = self.pos
  let end = self.end
  if self.pos < end {
    let c = self.data.code_unit_at(pos).to_int()
    if c >= 0xD800 && c <= 0xDBFF {
      let pos2 = pos + 1
      if pos2 < end {
        let c2 = self.data.code_unit_at(pos2).to_int()
        if c2 >= 0xDC00 && c2 <= 0xDFFF {
          self.pos = pos2 + 1
          return (c - 0xD800) * 0x400 + c2 - 0xDC00 + 0x10000
        }
      }
    }
    self.pos = pos + 1
    return c
  }
  -1
}

///|
pub impl IStringLexbuf for StringLexbuf with fn curr_pos(self) {
  self.pos
}

///|
pub impl IStringLexbuf for StringLexbuf with fn reset(self, pos~) {
  self.pos = pos
}

///|
pub impl IStringLexbuf for StringLexbuf with fn get_char(self, start, _end) {
  self.data.get_char(start).unwrap()
}

///|
pub impl IStringLexbuf for StringLexbuf with fn get_string(self, start, end) {
  self.data[start:end].to_owned()
}

///|
pub extend StringLexbuf with IStringLexbuf::{
  next_as_int,
  curr_pos,
  reset,
  get_char,
  get_string,
}
