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

  it 'returns a single country by name', vcr: {cassette_name: 'france country info'} do
    country = CountriesService.get_country("france")
    
    expect(country).to be_an Array

    country = country.first

    expect(country).to be_a Hash
    expect(country[:name][:common]).to eq("France")
    expect(country[:capitalInfo][:latlng]).to be_an Array
    expect(country[:capitalInfo][:latlng].length).to eq(2)
    expect(country[:capitalInfo][:latlng][0]).to be_a Float
    expect(country[:capitalInfo][:latlng][1]).to be_a Float
  end
end