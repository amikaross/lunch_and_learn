class CountryService
  def self.get_country
    response = conn.get("/v3.1/all")
    countries = JSON.parse(response.body, symbolize_names: true)
    names = countries.map do |country|
      country[:name][:common]
    end
    names.sample
  end

  def self.conn
    Faraday.new("https://restcountries.com")
  end
end