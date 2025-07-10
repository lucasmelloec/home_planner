pub opaque type Uuid(kind) {
  Uuid(String)
}

pub fn from_string(uuid: String) -> Uuid(kind) {
  Uuid(uuid)
}
