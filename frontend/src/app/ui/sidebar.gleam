import app/data/i18n
import app/route.{
  type Route, Details, MealPlanner, Products, Recipes, ShoppingList, to_title,
  to_uri,
}
import gleam/bool
import gleam/list
import gleam/option.{None, Some}
import gleam/string
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

pub fn view(
  sidebar_expanded: Bool,
  current_route: Route,
  above_size_breakpoint: Bool,
  i18n: fn(i18n.I18nKey) -> String,
  on_click_language_flag: fn(i18n.Lang) -> msg,
) -> Element(msg) {
  html.nav(
    [
      attribute.id("sidebar"),
      attribute.data(
        "expanded",
        string.lowercase(bool.to_string(sidebar_expanded)),
      ),
      attribute.class(
        "peer fixed md:sticky z-10 w-72 top-0 self-start h-screen -translate-x-full md:translate-none data-[expanded=true]:translate-x-0 transition-transform duration-200 ease-in-out shadow-lg md:shadow-none bg-primary [grid-area:sidebar]",
      ),
      case above_size_breakpoint || sidebar_expanded {
        False -> attribute.inert(True)
        True -> attribute.none()
      },
    ],
    [
      html.div([attribute.class("p-4 border-b border-error text-center h-15")], [
        html.a(
          [
            attribute.class("font-semibold text-lg text-color-text-secondary"),
            attribute.href("/"),
          ],
          [html.text(i18n(i18n.AppName))],
        ),
      ]),
      html.div([attribute.class("px-3 py-4")], [
        html.ul(
          [attribute.class("space-y-2 font-medium")],
          [ShoppingList, MealPlanner, Recipes, Products, Details]
            |> list.map(fn(route) {
              html.li([], [
                html.a(
                  [
                    attribute.class(
                      "flex items-center p-2 rounded-lg transition-colors duration-150 ease-in-out active:bg-error hover:bg-error aria-[current=page]:bg-error/30 aria-[current=page]:hover:bg-error",
                    ),
                    case route == current_route {
                      False -> attribute.none()
                      True -> attribute.aria_current("page")
                    },
                    attribute.href(route |> to_uri()),
                  ],
                  [
                    html.span([attribute.class("ms-3")], [
                      case route |> to_title(i18n) {
                        None -> element.none()
                        Some(title) -> html.text(title)
                      },
                    ]),
                  ],
                ),
              ])
            }),
        ),
        html.div(
          [attribute.class("absolute bottom-0 left-30 space-x-2 text-lg")],
          [
            html.a(
              [
                attribute.href("#"),
                event.on_click(on_click_language_flag(i18n.Pt)),
              ],
              [html.text("🇧🇷")],
            ),
            html.a(
              [
                attribute.href("#"),
                event.on_click(on_click_language_flag(i18n.En)),
              ],
              [html.text("🇺🇸")],
            ),
          ],
        ),
      ]),
    ],
  )
}
