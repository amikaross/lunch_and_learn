class RecipesService
  def self.recipes_by_country(country)
    response = conn.get("/api/recipes/v2?") do |req|
      req.params[:q] = "#{country}"
      req.params[:app_id] = ENV['edamam_app_id']
      req.params[:app_key] = ENV['edamam_app_key']
      req.params[:type] = 'public'
    end
    JSON.parse(response.body, symbolize_names: true)[:hits]
  end

  def self.conn 
    Faraday.new("https://api.edamam.com")
  end
end