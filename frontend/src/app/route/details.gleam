import app/data/measurement
import app/data/tag
import app/ui/list as list_ui
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(_) {
  let tags = tag.tag_list()
  let measurements = measurement.measurement_list()

  html.div([attribute.class("flex-1 flex flex-col max-w-500 mx-6")], [
    html.button([attribute.class("btn fixed top-3 right-6 min-w-20")], [
      html.text("Save"),
    ]),
    html.div([attribute.class("grid grid-cols-1 md:grid-cols-2 mt-3 gap-x-8")], [
      html.div([], [
        html.h2(
          [
            attribute.class(
              "text-center text-color-text-secondary font-semibold text-md my-3",
            ),
          ],
          [html.text("Tags")],
        ),
        list_ui.view_list(
          [],
          tags
            |> list.map(fn(item) {
              let assert Ok(first_item) = list.first(tags)
              list_ui.ListItem(value: item.name, disabled: item == first_item)
            }),
        ),
      ]),
      html.div([], [
        html.h2(
          [
            attribute.class(
              "text-center text-color-text-secondary font-semibold text-md my-3",
            ),
          ],
          [html.text("Measurements")],
        ),
        list_ui.view_list(
          [],
          measurements
            |> list.map(fn(item) {
              let assert Ok(first_item) = list.first(measurements)
              list_ui.ListItem(value: item.name, disabled: item == first_item)
            }),
        ),
      ]),
    ]),
  ])
}
