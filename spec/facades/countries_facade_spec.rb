require 'rails_helper'

RSpec.describe CountriesFacade do
  it 'returns a random country name', vcr: {cassette_name: 'all countries'} do
    country = CountriesFacade.random_country
    expect(country).to be_a(String)
  end

  it 'returns a single countrys capital lattitute and longitude', vcr: {cassette_name: 'france country info'} do
    latlong = CountriesFacade.capital_latlong("france")

    expect(latlong).to be_a Hash
    expect(latlong[:lat]).to be_a Float
    expect(latlong[:long]).to be_a Float
    expect(latlong.lenght).to eq(2)
  end
end