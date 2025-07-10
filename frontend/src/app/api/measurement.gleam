import gleam/list

pub type Measurement {
  Measurement(name: String)
}

pub fn measurement_list() -> List(Measurement) {
  ["Xícaras", "Colheres de Sopa", "Gramas"]
  |> list.map(fn(measurement_name) { Measurement(measurement_name) })
}
