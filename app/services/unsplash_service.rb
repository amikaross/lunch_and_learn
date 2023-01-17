class UnsplashService
  def images_by_country(country)
    response = conn.get("/search/photos") do |req|
      req.headers[:Authorization] = "Client-ID #{ENV['unsplash_key']}"
      req.params[:query] = "#{country}"
      req.params[:per_page] = "10"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn 
    Faraday.new("https://api.unsplash.com")
  end
end