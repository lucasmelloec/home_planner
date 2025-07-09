import gleam/int
import gleam/list

pub fn recipe_list() -> List(String) {
  list.range(1, 50)
  |> list.map(fn(count) { "Recipe " <> int.to_string(count) })
}
