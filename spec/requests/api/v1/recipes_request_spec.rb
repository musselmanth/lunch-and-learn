require 'rails_helper'

RSpec.describe 'Recipes Requests' do
  it 'returns a list of recipes when the country is provided', vcr: {cassette_name: 'greek recipes'} do
    get '/api/v1/recipes?country=greece'

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to have_key(:data)
    expect(body[:data]).to be_an Array
    
    body[:data].each do |recipe|
      expect(recipe[:id]).to be(nil)
      expect(recipe[:type]).to eq("recipe")
      expect(recipe[:attributes]).to be_a(Hash)
      expect(recipe[:attributes][:url]).to be_a(String)
      expect(recipe[:attributes][:title]).to be_a(String)
      expect(recipe[:attributes][:image]).to be_a(String)
      expect(recipe[:attributes][:country]).to eq("greece")
    end
  end
end