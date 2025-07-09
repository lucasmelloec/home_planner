import gleam/int
import gleam/list

pub fn product_list() -> List(String) {
  list.range(1, 50)
  |> list.map(fn(count) { "Product " <> int.to_string(count) })
}
