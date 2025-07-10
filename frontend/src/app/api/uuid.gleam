pub opaque type Uuid(kind) {
  Uuid(String)
}

pub fn from_string(uuid: String) -> Uuid(kind) {
  Uuid(uuid)
}

pub fn to_string(uuid: Uuid(kind)) -> String {
  let Uuid(value) = uuid
  value
}
