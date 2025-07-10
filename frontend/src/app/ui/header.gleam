import app/data/i18n
import app/route
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view(
  route: route.Route,
  i18n: fn(i18n.I18nKey) -> String,
  children: List(Element(_)),
) -> Element(_) {
  html.header(
    [
      attribute.class(
        "p-4 sticky top-0 [grid-area:header] border-b border-b-gray-400/30 flex flex-row",
      ),
    ],
    [
      html.h1(
        [
          attribute.class(
            "font-semibold text-lg self-center text-center flex-grow",
          ),
        ],
        [html.text(route |> route.to_title(i18n))],
      ),
    ]
      |> list.append(children),
  )
}
