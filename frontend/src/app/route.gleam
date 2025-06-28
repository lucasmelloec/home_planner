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

pub fn to_title(route: Route) -> String {
  case route {
    Details -> "Details"
    EditProduct(_) -> "Edit Product"
    EditRecipe(_) -> "Edit Recipe"
    MealPlanner -> "Meal Planner"
    NotFound -> "Not Found"
    Products -> "Products"
    Recipe(_) -> "Recipe"
    Recipes -> "Recipes"
    ShoppingList -> "Shopping List"
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
