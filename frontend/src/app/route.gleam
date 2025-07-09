import app/i18n
import gleam/option.{type Option, None, Some}
import gleam/uri.{type Uri}

pub type Uuid {
  Uuid(String)
}

pub type Route {
  ShoppingList
  MealPlanner
  Recipes
  Recipe(Uuid)
  EditRecipe(Option(Uuid))
  Products
  EditProduct(Option(Uuid))
  Details
  NotFound
}

pub const homepage: Route = ShoppingList

pub fn to_title(route: Route, i18n: fn(i18n.I18nKey) -> String) -> String {
  case route {
    Details -> i18n(i18n.DetailsRoute)
    EditProduct(_) -> "Edit Product"
    EditRecipe(_) -> "Edit Recipe"
    MealPlanner -> i18n(i18n.MealPlannerRoute)
    NotFound -> "Not Found"
    Products -> i18n(i18n.ProductsRoute)
    Recipe(_) -> "Recipe"
    Recipes -> i18n(i18n.RecipesRoute)
    ShoppingList -> i18n(i18n.ShoppingListRoute)
  }
}

pub fn from_uri(uri: Uri) -> Route {
  case uri.path_segments(uri.path) {
    [] -> homepage
    ["details"] -> Details
    ["mealplanner"] -> MealPlanner
    ["products"] -> Products
    ["products", product_uuid, "edit"] -> EditProduct(Some(Uuid(product_uuid)))
    ["products", "new"] -> EditProduct(None)
    ["recipes"] -> Recipes
    ["recipes", "new"] -> EditRecipe(None)
    ["recipes", recipe_uuid] -> Recipe(Uuid(recipe_uuid))
    ["recipes", recipe_uuid, "edit"] -> EditRecipe(Some(Uuid(recipe_uuid)))
    ["shoppinglist"] -> ShoppingList
    _ -> NotFound
  }
}

pub fn to_uri(route: Route) -> String {
  case route {
    Details -> "/details"
    EditProduct(_) -> ""
    EditRecipe(_) -> ""
    MealPlanner -> "/mealplanner"
    NotFound -> ""
    Products -> "/products"
    Recipe(_) -> ""
    Recipes -> "/recipes"
    ShoppingList -> "/shoppinglist"
  }
}
