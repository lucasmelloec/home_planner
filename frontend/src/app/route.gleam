import app/api/product
import app/api/recipe
import app/api/uuid.{type Uuid}
import app/data/i18n
import gleam/option.{type Option, None, Some}
import gleam/uri.{type Uri}

pub type Route {
  ShoppingList
  MealPlanner
  Recipes
  Recipe(Uuid(recipe.Recipe))
  EditRecipe(Option(Uuid(recipe.Recipe)))
  Products
  EditProduct(Option(Uuid(product.Product)))
  Details
  NotFound
}

pub const homepage: Route = ShoppingList

pub fn to_title(
  route: Route,
  i18n: fn(i18n.I18nKey) -> String,
) -> Option(String) {
  case route {
    Details -> Some(i18n(i18n.DetailsRoute))
    EditProduct(_) -> None
    EditRecipe(_) -> None
    MealPlanner -> Some(i18n(i18n.MealPlannerRoute))
    NotFound -> Some("Not Found")
    Products -> Some(i18n(i18n.ProductsRoute))
    Recipe(_) -> None
    Recipes -> Some(i18n(i18n.RecipesRoute))
    ShoppingList -> Some(i18n(i18n.ShoppingListRoute))
  }
}

pub fn from_uri(uri: Uri) -> Route {
  case uri.path_segments(uri.path) {
    [] -> homepage
    ["details"] -> Details
    ["mealplanner"] -> MealPlanner
    ["products"] -> Products
    ["products", product_uuid, "edit"] ->
      EditProduct(Some(uuid.from_string(product_uuid)))
    ["products", "new"] -> EditProduct(None)
    ["recipes"] -> Recipes
    ["recipes", "new"] -> EditRecipe(None)
    ["recipes", recipe_uuid] -> Recipe(uuid.from_string(recipe_uuid))
    ["recipes", recipe_uuid, "edit"] ->
      EditRecipe(Some(uuid.from_string(recipe_uuid)))
    ["shoppinglist"] -> ShoppingList
    _ -> NotFound
  }
}

pub fn to_uri(route: Route) -> String {
  case route {
    Details -> "/details"
    EditProduct(product) ->
      case product {
        None -> "/products/new"
        Some(product_uuid) ->
          "/products/" <> uuid.to_string(product_uuid) <> "/edit"
      }
    EditRecipe(_) -> ""
    MealPlanner -> "/mealplanner"
    NotFound -> ""
    Products -> "/products"
    Recipe(_) -> ""
    Recipes -> "/recipes"
    ShoppingList -> "/shoppinglist"
  }
}
