require 'rails_helper'

RSpec.describe 'Recipes Requests' do
  it 'returns a list of recipes when the country is provided', vcr: {cassette_name: 'greek recipes'} do
    get '/api/v1/recipes?country=greece'

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to have_key(:data)
    expect(body[:data]).to be_an Array

    expect(body[:data]).to_not be_empty
    
    body[:data].each do |recipe|
      expect(recipe[:id]).to be(nil)
      expect(recipe[:type]).to eq("recipe")
      expect(recipe[:attributes]).to be_a(Hash)
      expect(recipe[:attributes].length).to eq(4)
      expect(recipe[:attributes][:url]).to be_a(String)
      expect(recipe[:attributes][:title]).to be_a(String)
      expect(recipe[:attributes][:image]).to be_a(String)
      expect(recipe[:attributes][:country]).to eq("greece")
    end
  end

  it 'returns a list of recipes when the country is not provided', vcr: {cassette_name: 'turkish recipes'} do
    allow(CountriesFacade).to receive(:random_country).and_return("turkey")

    get '/api/v1/recipes'

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to have_key(:data)
    expect(body[:data]).to be_an Array

    expect(body[:data]).to_not be_empty

    body[:data].each do |recipe|
      expect(recipe[:id]).to be(nil)
      expect(recipe[:type]).to eq("recipe")
      expect(recipe[:attributes].length).to eq(4)
      expect(recipe[:attributes]).to be_a(Hash)
      expect(recipe[:attributes][:url]).to be_a(String)
      expect(recipe[:attributes][:title]).to be_a(String)
      expect(recipe[:attributes][:image]).to be_a(String)
      expect(recipe[:attributes][:country]).to eq("turkey")
    end
  end

  it 'returns empty array for data if there are no results', vcr: {cassette_name: 'empty recipes'} do
    get '/api/v1/recipes?country=musselmanland'

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data]).to be_an(Array)
    expect(body[:data]).to be_empty
  end

  it 'returns empty data array if empty string is passed', vcr: {cassette_name: 'empty recipes'} do
    get '/api/v1/recipes?country='

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data]).to be_an(Array)
    expect(body[:data]).to be_empty
  end
end