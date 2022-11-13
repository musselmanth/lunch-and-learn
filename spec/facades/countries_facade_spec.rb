require 'rails_helper'

RSpec.describe CountriesFacade do
  it 'returns a random country name', vcr: {cassette_name: 'all countries'} do
    country = CountriesFacade.random_country
    expect(country).to be_a(String)
  end
end