import gleam/list

pub type Tag {
  Tag(name: String)
}

pub fn tag_list() -> List(Tag) {
  ["Ingrediente", "Higiene", "Limpeza"]
  |> list.map(fn(tag_name) { Tag(tag_name) })
}
