require 'rails_helper'

RSpec.describe CountriesFacade do
  it 'returns a random country name', vcr: {cassette_name: 'all countries'} do
    country = CountriesFacade.random_country
    expect(country).to be_a(String)
  end

  it 'returns a single countrys capital lattitute and longitude', vcr: {cassette_name: 'france country info'} do
    latlong = CountriesFacade.capital_latlong("france")

    expect(latlong).to be_a Hash
    expect(latlong[:lat]).to eq(48.87)
    expect(latlong[:long]).to eq(2.33)
    expect(latlong.length).to eq(2)
  end
end