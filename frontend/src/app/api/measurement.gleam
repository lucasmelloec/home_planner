import gleam/list

pub type Measurement {
  Measurement(name: String)
}

pub fn measurement_list() -> List(Measurement) {
  ["Xĩcaras", "Colheres de Sopa", "Gramas"]
  |> list.map(fn(measurement_name) { Measurement(measurement_name) })
}
