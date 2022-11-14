class CountriesFacade
  def self.random_country
    binding.pry
    all_country_names.sample
  end

  def self.capital_latlong(country)
    country = CountriesService.get_country(country).first
    {
      lat: country[:capitalInfo][:latlng][0],
      long: country[:capitalInfo][:latlng][1]
    }
  end

  def self.valid_country?(country)
    all_country_names.include?(country.downcase)
  end

  private

  def self.all_country_names
    countries = CountriesService.get_all_countries
    countries.map {|country| country[:name][:common].downcase}
  end
end