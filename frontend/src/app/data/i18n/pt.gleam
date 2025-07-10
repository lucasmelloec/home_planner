import app/data/i18n

pub fn i18n(key: i18n.I18nKey) -> String {
  case key {
    i18n.AppName -> "Home Planner"
    i18n.DetailsRoute -> "Detalhes"
    i18n.MealPlannerRoute -> "Planejador de Refeições"
    i18n.NewRecipe -> "Nova Receita"
    i18n.ProductsRoute -> "Produtos"
    i18n.RecipesRoute -> "Receitas"
    i18n.SearchRecipe -> "Procurar Receita"
    i18n.ShoppingListRoute -> "Lista de Compras"
    i18n.NewProduct -> "Novo Produto"
    i18n.SearchProduct -> "Procurar Produto"
    i18n.MeasurementsHeader -> "Medidas"
    i18n.Save -> "Salvar"
    i18n.TagsHeader -> "Tags"
    i18n.NoItemsFound -> "Nenhum Item Encontrado"
  }
}
