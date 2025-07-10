import app/api/measurement
import app/api/product
import app/data/i18n
import app/ui/header
import app/ui/list as list_ui
import app/ui/main
import gleam/int
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn ingredients_list(i18n) {
  fn(item: list_ui.ListItem(#(Int, measurement.Measurement, product.Product))) {
    html.span([attribute.class("flex flex-row items-center space-x-1")], [
      html.input([
        attribute.type_("text"),
        attribute.value(int.to_string(item.value.0)),
        attribute.class("text-box max-w-10"),
      ]),
      html.select(
        [attribute.class("text-box")],
        measurement.measurement_list()
          |> list.map(fn(measurement) {
            html.option(
              [attribute.selected(measurement == item.value.1)],
              measurement.name,
            )
          }),
      ),
      html.p([], [html.text(i18n(i18n.Of))]),
      html.select(
        [attribute.class("text-box")],
        product.product_list()
          |> list.map(fn(product) {
            html.option([attribute.selected(product == item.value.2)], product)
          }),
      ),
    ])
  }
}

pub fn view(i18n: fn(i18n.I18nKey) -> String) -> Element(_) {
  element.fragment([
    header.view_edit(i18n(i18n.NewRecipe), i18n),
    main.view([
      html.div([attribute.class("mt-3 flex flex-col space-y-8")], [
        html.p([], [
          html.input([
            attribute.type_("text"),
            attribute.class("text-box max-w-10"),
          ]),
          html.text(" " <> i18n(i18n.Meals)),
        ]),
        html.div([], [
          html.h2([attribute.class("font-semibold text-md")], [
            html.text(i18n(i18n.IngredientsHeader)),
          ]),
          {
            let assert Ok(measurement) =
              list.sample(measurement.measurement_list(), 1) |> list.first()
            let assert Ok(product) =
              list.sample(product.product_list(), 1) |> list.first()
            list_ui.view_custom_list(
              [
                list_ui.ListItem(
                  value: #(3, measurement, product),
                  disabled: False,
                ),
              ],
              ingredients_list(i18n),
            )
          },
        ]),
        html.div([], [
          html.h2([attribute.class("font-semibold text-md")], [
            html.text(i18n(i18n.PreparationHeader)),
          ]),
          html.textarea([attribute.class("text-box h-40 w-full")], ""),
        ]),
        html.div([], [
          html.h2([attribute.class("font-semibold text-md")], [
            html.text(i18n(i18n.ImportantInformationHeader)),
          ]),
          html.textarea([attribute.class("text-box h-40 w-full")], ""),
        ]),
      ]),
    ]),
  ])
}
