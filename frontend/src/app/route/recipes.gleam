import app/api/recipe
import app/data/i18n
import app/route
import app/ui/card
import app/ui/header
import app/ui/icon
import app/ui/main
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view(i18n: fn(i18n.I18nKey) -> String) -> Element(_) {
  element.fragment([
    header.view(route.Recipes, i18n, []),
    main.view([
      html.div(
        [
          attribute.class(
            "items-center h-20 sticky top-15 flex flex-row bg-background space-x-2 md:space-x-8",
          ),
        ],
        [
          html.div([attribute.class("relative flex-1")], [
            html.input([
              attribute.class("text-box w-full pr-9"),
              attribute.type_("text"),
              attribute.placeholder(i18n(i18n.SearchRecipe)),
            ]),
            html.label(
              [attribute.class("absolute right-2 top-1/8 text-error")],
              [icon.search()],
            ),
          ]),
          html.button([attribute.class("btn text-nowrap")], [
            html.text(i18n(i18n.NewRecipe)),
          ]),
        ],
      ),
      card.view_card_list([], recipe.recipe_list(), i18n),
    ]),
  ])
}
