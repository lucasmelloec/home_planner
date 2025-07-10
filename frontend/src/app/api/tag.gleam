import gleam/int
import gleam/list

pub type Tag {
  Tag(name: String)
}

pub fn tag_list() -> List(Tag) {
  list.range(1, 4)
  |> list.map(fn(count) { Tag(name: "Tag " <> int.to_string(count)) })
}
