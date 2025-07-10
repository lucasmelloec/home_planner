import gleam/int
import gleam/list

pub type Product =
  String

pub fn product_list() -> List(Product) {
  list.range(1, 50)
  |> list.map(fn(count) { "Product " <> int.to_string(count) })
}
