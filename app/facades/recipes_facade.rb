class RecipesFacade 
  def self.recipes_by_country(country)
    country = CountryService.get_country if country.nil?
    recipes_data = RecipesService.recipes_by_country(country)
    recipes_data.map do |data|
      Recipe.new(data, country)
    end
  end
end