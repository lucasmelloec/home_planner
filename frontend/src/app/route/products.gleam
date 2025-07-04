import app/data/product
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(_) {
  html.div([attribute.class("flex flex-col space-y-6")], [
    html.div([attribute.class("flex flex-row space-x-4 xl:space-x-16")], [
      html.input([
        attribute.class("text-box min-w-65 xl:w-400"),
        attribute.type_("text"),
        attribute.placeholder("Search Product"),
      ]),
      html.div([attribute.class("")], [
        html.button([attribute.class("btn")], [html.text("New Product")]),
      ]),
    ]),
    html.div([attribute.class("flex-1")], [
      html.ul(
        [
          attribute.class(
            "grid grid-cols-1 sm:grid-cols-2 justify-stretch overflow-auto",
          ),
        ],
        product.product_list
          |> list.map(fn(product) {
            html.li(
              [
                attribute.class(
                  "max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow-sm hover:bg-gray-100",
                ),
              ],
              [html.p([], [html.text(product)])],
            )
          }),
      ),
    ]),
  ])
}
