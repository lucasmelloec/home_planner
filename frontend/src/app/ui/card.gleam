import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/vdom/vattr

pub fn view(value: String) -> Element(_) {
  html.li(
    [
      attribute.class(
        "p-6 md:mx-4 my-3 bg-surface/80 border border-error rounded-lg shadow-sm hover:bg-primary active:bg-primary",
      ),
    ],
    [html.p([], [html.text(value)])],
  )
}

pub fn view_list(
  attributes: List(vattr.Attribute(a)),
  card_list: List(String),
) -> Element(_) {
  case list.is_empty(card_list) {
    True ->
      html.p([attribute.class("text-center flex-1 content-center")], [
        html.text("No Products Found"),
      ])
    False ->
      html.ul(
        list.append(attributes, [attribute.class("grid grid-cols-1 mx-[2px]")]),
        card_list
          |> list.map(fn(product) { view(product) }),
      )
  }
}
