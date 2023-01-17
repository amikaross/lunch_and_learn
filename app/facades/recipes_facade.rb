class RecipesFacade 
  def self.recipes_by_country(country)
    country = get_random_country if country.nil?
    recipes_data = RecipesService.recipes_by_country(country)
    recipes_data.map do |data|
      Recipe.new(data, country)
    end
  end

  def self.get_random_country
    countries = CountryService.get_country
    names = countries.map { |country| country[:name][:common] }
    names.sample
  end
end