import app/ui/sidebar
import gleam/option.{type Option, None, Some}
import gleam/uri.{type Uri}
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import modem

const homepage: Route = ShoppingList

type Uuid =
  String

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
}

type Model {
  Model(route: Route)
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

fn init(_) -> #(Model, Effect(Msg)) {
  let route = case modem.initial_uri() {
    Ok(uri) -> route_from_uri(uri)
    Error(Nil) -> homepage
  }

  let model = Model(route:)

  #(model, modem.init(on_uri_change))
}

fn route_from_uri(uri: Uri) -> Route {
  case uri.path_segments(uri.path) {
    [] -> homepage
    ["shoppinglist"] -> ShoppingList
    ["mealplanner"] -> MealPlanner
    ["recipes"] -> Recipes
    ["recipes", "new"] -> EditRecipe(None)
    ["recipes", recipe_uuid] -> Recipe(recipe_uuid)
    ["recipes", recipe_uuid, "edit"] -> EditRecipe(Some(recipe_uuid))
    ["products"] -> Products
    ["products", product_uuid, "edit"] -> EditProduct(Some(product_uuid))
    ["products", "new"] -> EditProduct(None)
    ["details"] -> Details
    _ -> NotFound
  }
}

fn on_uri_change(uri: Uri) -> Msg {
  OnRouteChange(route_from_uri(uri))
}

pub type Msg {
  OnRouteChange(Route)
}

fn update(_, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    OnRouteChange(route) -> #(Model(route:), effect.none())
  }
}

fn view(model: Model) -> Element(Msg) {
  html.div([attribute.class("flex flex-row")], [
    sidebar.view(),
    case model.route {
      ShoppingList ->
        html.h1([attribute.class("p-6 text-xl font-bold")], [
          html.text("You're on Shopping List"),
        ])
      MealPlanner ->
        html.h1([attribute.class("p-6 text-xl font-bold")], [
          html.text("You're on Meal Planner"),
        ])
      Recipes ->
        html.h1([attribute.class("p-6 text-xl font-bold")], [
          html.text("You're on Recipes"),
        ])
      Products ->
        html.h1([attribute.class("p-6 text-xl font-bold")], [
          html.text("You're on Products"),
        ])
      Details ->
        html.h1([attribute.class("p-6 text-xl font-bold")], [
          html.text("You're on Details"),
        ])
      _ ->
        html.h1([attribute.class("p-6 text-xl font-bold")], [
          html.text("Page Not Found"),
        ])
    },
  ])
}
