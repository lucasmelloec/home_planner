import app/data/product
import app/ui/card
import app/ui/icon
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(_) {
  html.div([attribute.class("flex-1 flex flex-col max-w-500 mx-6")], [
    html.div(
      [
        attribute.class(
          "items-center h-20 sticky top-[61px] md:mx-4 flex flex-row bg-background space-x-2 md:space-x-8",
        ),
      ],
      [
        html.div([attribute.class("relative flex-1")], [
          html.input([
            attribute.class("text-box w-full pr-9"),
            attribute.type_("text"),
            attribute.placeholder("Search Product"),
          ]),
          html.label([attribute.class("absolute right-2 top-1/8 text-error")], [
            icon.search(),
          ]),
        ]),
        html.button([attribute.class("btn text-nowrap")], [
          html.text("New Product"),
        ]),
      ],
    ),
    case list.is_empty(product.product_list()) {
      True ->
        html.p([attribute.class("text-center flex-1 content-center")], [
          html.text("No Products Found"),
        ])
      False ->
        html.ul(
          [attribute.class("grid grid-cols-1 md:grid-cols-2 mx-[2px]")],
          product.product_list()
            |> list.map(fn(product) { card.view(product) }),
        )
    },
  ])
}
