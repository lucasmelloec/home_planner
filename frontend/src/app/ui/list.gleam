import app/ui/card
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/vdom/vattr

pub fn view_list(
  attributes: List(vattr.Attribute(_)),
  item_list: List(String),
) -> Element(_) {
  html.ul(
    list.append(attributes, [
      attribute.class("grid grid-cols-1 mx-[2px] gap-y-6 gap-x-8"),
    ]),
    item_list
      |> list.map(fn(item) {
        html.div(
          [attribute.class("flex flex-row items-center space-x-5 md:space-x-2")],
          [
            html.button(
              [attribute.class("btn aspect-square w-8 text-md font-semibold")],
              [html.text("-")],
            ),
            card.view_card([], item),
          ],
        )
      }),
  )
}
