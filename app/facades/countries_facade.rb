class CountriesFacade
  def self.random_country
    countries = CountriesService.get_all_countries
    countries.map {|country| country[:name][:common]}.sample
  end

  def self.capital_latlong(country)
    country = CountriesService.get_country(country).first
    {
      lat: country[:capitalInfo][:latlng][0],
      long: country[:capitalInfo][:latlng][1]
    }
  end
end