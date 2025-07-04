import app/route.{
  Details, MealPlanner, Products, Recipes, ShoppingList, to_title, to_uri,
}
import gleam/bool
import gleam/list
import gleam/string
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

pub fn view(
  sidebar_expanded: Bool,
  on_click_dashboard_link: msg,
) -> Element(msg) {
  html.aside(
    [
      attribute.data(
        "expanded",
        string.lowercase(bool.to_string(sidebar_expanded)),
      ),
      attribute.class(
        "fixed h-full flex flex-col sm:relative w-72 data-[expanded=true]:translate-x-0 sm:translate-none -translate-x-full transition-transform duration-200 ease-in-out shadow-lg sm:shadow-none bg-primary",
      ),
    ],
    [
      html.div(
        [
          attribute.class(
            "h-18 flex justify-center items-center border-b border-error",
          ),
        ],
        [
          html.a(
            [
              attribute.class("font-semibold text-lg text-color-text-secondary"),
              attribute.href("/"),
              event.on_click(on_click_dashboard_link),
            ],
            [html.text("Home Planner")],
          ),
        ],
      ),
      html.div([attribute.class("flex-1 px-3 py-4 overflow-y-auto")], [
        html.ul(
          [attribute.class("space-y-2 font-medium")],
          [ShoppingList, MealPlanner, Recipes, Products, Details]
            |> list.map(fn(route) {
              html.li([], [
                html.a(
                  [
                    attribute.class(
                      "flex items-center p-2 rounded-lg active:bg-error hover:bg-error",
                    ),
                    attribute.href(route |> to_uri()),
                    event.on_click(on_click_dashboard_link),
                  ],
                  [
                    html.span([attribute.class("ms-3")], [
                      html.text(route |> to_title()),
                    ]),
                  ],
                ),
              ])
            }),
        ),
      ]),
    ],
  )
}
