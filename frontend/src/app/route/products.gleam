import app/data/product
import app/ui/card
import app/ui/icon
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(_) {
  html.div([attribute.class("flex-1 flex flex-col max-w-500 mx-6")], [
    html.div(
      [
        attribute.class(
          "items-center h-20 sticky top-[61px] flex flex-row bg-background space-x-2 md:space-x-8",
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
    card.view_card_list(
      [attribute.class("md:grid-cols-2")],
      product.product_list(),
    ),
  ])
}
