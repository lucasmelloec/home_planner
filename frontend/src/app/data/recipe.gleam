import gleam/int
import gleam/list

pub fn recipe_list() -> List(String) {
  list.range(1, 50)
  |> list.map(fn(product_number) { "Recipe " <> int.to_string(product_number) })
}
