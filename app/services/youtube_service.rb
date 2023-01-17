class YoutubeService
  def video_by_country(country)
    response = conn.get("/youtube/v3/search") do |req|
      req.params[:key] = ENV['google_api_key']
      req.params[:part] = 'snippet'
      req.params[:channelId] = 'UCluQ5yInbeAkkeCndNnUhpw'
      req.params[:maxResults] = '1'
      req.params[:q] = "#{country}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://www.googleapis.com")
  end
end