import app/data/i18n
import app/route
import gleam/list
import gleam/option.{None, Some}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view(
  route: route.Route,
  i18n: fn(i18n.I18nKey) -> String,
  children: List(Element(a)),
) -> Element(a) {
  html.header(
    [
      attribute.class(
        "p-4 sticky top-0 h-15 [grid-area:header] border-b border-b-gray-400/30 flex flex-row items-center",
      ),
    ],
    [
      html.h1([attribute.class("font-semibold text-lg text-center flex-grow")], [
        case route.to_title(route, i18n) {
          None -> element.none()
          Some(title) -> html.text(title)
        },
      ]),
    ]
      |> list.append(children),
  )
}

pub fn view_edit(
  item_name: String,
  i18n: fn(i18n.I18nKey) -> String,
) -> Element(a) {
  html.header(
    [
      attribute.class(
        "p-4 sticky top-0 h-15 [grid-area:header] border-b border-b-gray-400/30 flex flex-row items-center justify-end space-x-4",
      ),
    ],
    [
      html.div(
        [attribute.class("md:flex-grow md:flex md:justify-center xl:w")],
        [
          html.input([
            attribute.class("text-box md:w-150"),
            attribute.type_("text"),
            attribute.value(item_name),
          ]),
        ],
      ),
      html.button([attribute.class("btn min-w-20")], [
        html.text(i18n(i18n.Save)),
      ]),
    ],
  )
}
