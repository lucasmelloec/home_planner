import app/api/measurement
import app/api/tag
import app/data/i18n
import app/route
import app/ui/header
import app/ui/list as list_ui
import app/ui/main
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view(i18n: fn(i18n.I18nKey) -> String) -> Element(_) {
  let tags = tag.tag_list()
  let measurements = measurement.measurement_list()
  element.fragment([
    header.view(route.Details, i18n, [
      html.button([attribute.class("btn min-w-20")], [
        html.text(i18n(i18n.Save)),
      ]),
    ]),
    main.view([], [
      html.div(
        [attribute.class("grid grid-cols-1 md:grid-cols-2 mt-3 gap-x-8")],
        [
          html.div([], [
            html.h2(
              [
                attribute.class(
                  "text-center text-color-text-secondary font-semibold text-md my-3",
                ),
              ],
              [html.text(i18n(i18n.TagsHeader))],
            ),
            list_ui.view_list(
              [],
              tags
                |> list.map(fn(item) {
                  let assert Ok(first_item) = list.first(tags)
                  list_ui.ListItem(
                    value: item.name,
                    disabled: item == first_item,
                  )
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
              [html.text(i18n(i18n.MeasurementsHeader))],
            ),
            list_ui.view_list(
              [],
              measurements
                |> list.map(fn(item) {
                  let assert Ok(first_item) = list.first(measurements)
                  list_ui.ListItem(
                    value: item.name,
                    disabled: item == first_item,
                  )
                }),
            ),
          ]),
        ],
      ),
    ]),
  ])
}
