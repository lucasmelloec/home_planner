import lustre/attribute
import lustre/element/html

pub fn view() {
  html.aside(
    [
      attribute.class(
        "top-0 left-0 z-40 w-64 h-screen bg-white shadow-md flex flex-col",
      ),
    ],
    [
      html.div(
        [attribute.class("h-16 flex items-center justify-center border-b")],
        [
          html.h1([attribute.class("text-xl font-bold text-gray-700")], [
            html.text("Home Planner"),
          ]),
        ],
      ),
      html.nav([attribute.class("flex-1 p-4 space-y-2")], [
        html.a(
          [
            attribute.href("/shoppinglist"),
            attribute.class(
              "block px-4 py-2 rounded hover:bg-gray-200 text-gray-700",
            ),
          ],
          [html.text("Shopping List")],
        ),
        html.a(
          [
            attribute.href("/mealplanner"),
            attribute.class(
              "block px-4 py-2 rounded hover:bg-gray-200 text-gray-700",
            ),
          ],
          [html.text("Meal Planner")],
        ),
        html.a(
          [
            attribute.href("/recipes"),
            attribute.class(
              "block px-4 py-2 rounded hover:bg-gray-200 text-gray-700",
            ),
          ],
          [html.text("Recipes")],
        ),
        html.a(
          [
            attribute.href("/products"),
            attribute.class(
              "block px-4 py-2 rounded hover:bg-gray-200 text-gray-700",
            ),
          ],
          [html.text("Products")],
        ),
        html.a(
          [
            attribute.href("/details"),
            attribute.class(
              "block px-4 py-2 rounded hover:bg-gray-200 text-gray-700",
            ),
          ],
          [html.text("Details")],
        ),
      ]),
    ],
  )
}
