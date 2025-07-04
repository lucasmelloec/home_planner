import gleam/int
import gleam/list

pub fn product_list() -> List(String) {
  list.range(1, 50)
  |> list.map(fn(product_number) { "Product " <> int.to_string(product_number) })
}
