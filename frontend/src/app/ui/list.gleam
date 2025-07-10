import app/ui/icon
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub type ListItem(value_type) {
  ListItem(value: value_type, disabled: Bool)
}

pub fn view_list(item_list: List(ListItem(String))) -> Element(_) {
  html.ul(
    [attribute.class("grid grid-cols-1 mx-[2px] gap-y-6 gap-x-8")],
    item_list
      |> list.map(fn(item) {
        html.div(
          [attribute.class("flex flex-row items-center space-x-5 md:space-x-2")],
          [
            html.button(
              [
                attribute.class("btn"),
                attribute.disabled(item.disabled),
                attribute.inert(item.disabled),
              ],
              [icon.minus()],
            ),
            html.input([
              attribute.class("text-box w-full pr-9"),
              attribute.type_("text"),
              attribute.value(item.value),
              attribute.disabled(item.disabled),
            ]),
          ],
        )
      })
      |> list.append([
        html.button([attribute.class("btn place-self-center -mt-2")], [
          icon.plus(),
        ]),
      ]),
  )
}

pub fn view_custom_list(
  item_list: List(ListItem(value_type)),
  ui_view: fn(ListItem(value_type)) -> Element(a),
) -> Element(a) {
  html.ul(
    [attribute.class("grid grid-cols-1 mx-[2px] gap-y-4 gap-x-8")],
    item_list
      |> list.map(fn(item) {
        html.div(
          [attribute.class("flex flex-row items-center space-x-5 md:space-x-2")],
          [
            html.button(
              [
                attribute.class("btn"),
                attribute.disabled(item.disabled),
                attribute.inert(item.disabled),
              ],
              [icon.minus()],
            ),
            ui_view(item),
          ],
        )
      })
      |> list.append([
        html.button([attribute.class("btn place-self-start")], [icon.plus()]),
      ]),
  )
}
