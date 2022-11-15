class CountriesService

  def self.get_all_countries
    Rails.cache.fetch("all_countries", expires_in: 180.days) do
      response = connection.get("/v3.1/all")
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  private

  def self.connection
    Faraday.new(url: "https://restcountries.com")
  end
end