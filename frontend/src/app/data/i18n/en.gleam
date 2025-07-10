import app/data/i18n

pub fn i18n(key: i18n.I18nKey) -> String {
  case key {
    i18n.AppName -> "Home Planner"
    i18n.DetailsRoute -> "Details"
    i18n.MealPlannerRoute -> "Meal Planner"
    i18n.NewRecipe -> "New Recipe"
    i18n.ProductsRoute -> "Products"
    i18n.RecipesRoute -> "Recipes"
    i18n.SearchRecipe -> "Search Recipe"
    i18n.ShoppingListRoute -> "Shopping List"
    i18n.NewProduct -> "New Product"
    i18n.SearchProduct -> "Search Product"
    i18n.MeasurementsHeader -> "Measurements"
    i18n.Save -> "Save"
    i18n.TagsHeader -> "Tags"
    i18n.NoItemsFound -> "No Items Found"
    i18n.ConversionsHeader -> "Conversions"
    i18n.QuantityHeader -> "Market Quantity"
    i18n.RecurrencesHeader -> "Buying Recurrence"
    i18n.RecurrenceMessage -> "Every"
    i18n.RecurrenceFrequency -> "Days"
    i18n.Meals -> "Meals"
    i18n.IngredientsHeader -> "Ingredients"
    i18n.Of -> "Of"
    i18n.PreparationHeader -> "How to Prepare"
    i18n.ImportantInformationHeader -> "Important Information"
  }
}
