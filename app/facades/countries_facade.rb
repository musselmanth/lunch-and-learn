class CountriesFacade
  def self.random_country
    countries = CountriesService.get_all_countries
    countries.map {|country| country[:name][:common]}.sample
  end
end