import app/api/measurement
import app/api/tag
import app/data/i18n
import app/ui/header
import app/ui/list as list_ui
import app/ui/main
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

fn tag_selector(item: list_ui.ListItem(tag.Tag)) -> Element(_) {
  let tags = tag.tag_list()
  html.select(
    [attribute.name("Configured Tag"), attribute.class("text-box")],
    tags
      |> list.map(fn(tag) {
        html.option([attribute.selected(item.value == tag)], tag.name)
      }),
  )
}

fn conversions(
  item: list_ui.ListItem(#(String, measurement.Measurement)),
) -> Element(_) {
  let measurements = measurement.measurement_list()
  html.div([attribute.class("space-x-5")], [
    html.input([
      attribute.class("text-box max-w-20 text-right"),
      attribute.type_("text"),
      attribute.value(item.value.0),
    ]),
    html.select(
      [attribute.name("Measurement"), attribute.class("text-box")],
      measurements
        |> list.map(fn(measurement) {
          html.option(
            [attribute.selected(item.value.1 == measurement)],
            measurement.name,
          )
        }),
    ),
  ])
}

pub fn view(i18n: fn(i18n.I18nKey) -> String) -> Element(_) {
  element.fragment([
    header.view_edit(i18n(i18n.NewProduct), i18n),
    main.view([
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
            list_ui.view_custom_list(
              tag.tag_list()
                |> list.sample(2)
                |> list.map(fn(tag) {
                  list_ui.ListItem(value: tag, disabled: False)
                }),
              tag_selector,
            ),
          ]),
          html.div([], [
            html.h2(
              [
                attribute.class(
                  "text-center text-color-text-secondary font-semibold text-md my-3",
                ),
              ],
              [html.text(i18n(i18n.QuantityHeader))],
            ),
            html.div(
              [
                attribute.class(
                  "flex flex-row items-center md:justify-center space-x-5",
                ),
              ],
              [
                html.input([
                  attribute.class("text-box max-w-20 text-right"),
                  attribute.type_("text"),
                ]),
                html.select(
                  [attribute.name("measurement"), attribute.class("text-box")],
                  measurement.measurement_list()
                    |> list.map(fn(measurement) {
                      html.option([], measurement.name)
                    }),
                ),
              ],
            ),
          ]),
          html.div([], [
            html.h2(
              [
                attribute.class(
                  "text-center text-color-text-secondary font-semibold text-md my-3",
                ),
              ],
              [html.text(i18n(i18n.ConversionsHeader))],
            ),
            list_ui.view_custom_list(
              [
                list_ui.ListItem(
                  value: #("30", {
                    let assert Ok(measurement) =
                      measurement.measurement_list()
                      |> list.sample(1)
                      |> list.first()
                    measurement
                  }),
                  disabled: False,
                ),
              ],
              conversions,
            ),
          ]),
          html.div([], [
            html.h2(
              [
                attribute.class(
                  "text-center text-color-text-secondary font-semibold text-md my-3",
                ),
              ],
              [html.text(i18n(i18n.RecurrencesHeader))],
            ),
            html.div(
              [
                attribute.class(
                  "flex flex-row md:justify-center items-center space-x-4",
                ),
              ],
              [
                html.p([], [html.text(i18n(i18n.RecurrenceMessage))]),
                html.select(
                  [
                    attribute.name("Recurrence"),
                    attribute.class("text-box text-center"),
                  ],
                  [
                    html.option([], "0"),
                    html.option([], "7"),
                    html.option([], "30"),
                  ],
                ),
                html.p([], [html.text(i18n(i18n.RecurrenceFrequency))]),
              ],
            ),
          ]),
        ],
      ),
    ]),
  ])
}
