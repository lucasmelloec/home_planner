import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/vdom/vattr

pub fn view_card(
  attributes: List(vattr.Attribute(_)),
  value: String,
) -> Element(_) {
  html.li(
    list.append(attributes, [
      attribute.class(
        "p-6 bg-surface/80 border border-error rounded-lg shadow-sm hover:bg-primary active:bg-primary flex-1",
      ),
    ]),
    [html.p([], [html.text(value)])],
  )
}

pub fn view_card_list(
  attributes: List(vattr.Attribute(_)),
  card_list: List(String),
) -> Element(_) {
  case list.is_empty(card_list) {
    True ->
      html.p([attribute.class("text-center flex-1 content-center")], [
        html.text("No Items Found"),
      ])
    False ->
      html.ul(
        list.append(attributes, [
          attribute.class("grid grid-cols-1 mx-[2px] gap-y-6 gap-x-8"),
        ]),
        card_list
          |> list.map(fn(product) { view_card([], product) }),
      )
  }
}
