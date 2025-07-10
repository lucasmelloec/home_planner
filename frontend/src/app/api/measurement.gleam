import gleam/int
import gleam/list

pub type Measurement {
  Measurement(name: String)
}

pub fn measurement_list() -> List(Measurement) {
  list.range(1, 3)
  |> list.map(fn(count) {
    Measurement(name: "Measurement " <> int.to_string(count))
  })
}
