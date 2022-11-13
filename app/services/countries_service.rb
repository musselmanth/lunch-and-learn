class CountriesService

  def self.get_all_countries
    response = connection.get("/v3.1/all")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.connection
    Faraday.new(url: "https://restcountries.com")
  end
end