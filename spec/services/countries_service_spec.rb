require 'rails_helper'

RSpec.describe CountriesService do
  it 'returns a list of all countries', vcr: {cassette_name: 'all countries'} do
    countries = CountriesService.get_all_countries
    expect(countries).to be_an(Array)
    expect(countries.length).to eq(250)
    countries.each do |country|
      expect(country).to be_a(Hash)
      expect(country).to have_key(:name)
      expect(country[:name]).to be_a(Hash)
      expect(country[:name]).to have_key(:common)
      expect(country[:name][:common]).to be_a String
    end
  end
end