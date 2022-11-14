require 'rails_helper'

RSpec.describe 'get tourist sights endpoint' do
  describe 'happy path' do
    it 'returns a response with a list of tourist sites for a given country', vcr: {cassette_name: 'france tourist sights request'} do
      get '/api/v1/tourist_sights?country=france'

      expect(response).to be_successful
      expect(response).to have_http_status(200)
  
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:data)
      expect(body[:data]).to be_an(Array)
  
      tourist_sights = body[:data]

      tourist_sights.each do |tourist_site|
        expect(tourist_site[:id]).to be nil
        expect(tourist_site[:type]).to eq("tourist_sight")
        expect(tourist_site).to have_key(:attributes)
        expect(tourist_site[:attributes]).to be_a Hash
        expect(tourist_site[:attributes].length).to eq(3) #no unnecessary data
        expect(tourist_site[:attributes][:name]).to be_a String
        expect(tourist_site[:attributes][:place_id]).to be_a String
        expect(tourist_site[:attributes][:address]).to be_a String
      end
    end

    it 'returns a random country if no country provided', vcr: {cassette_name: 'latvia tourist sights request'} do
      allow(CountriesFacade).to receive(:random_country).and_return("latvia")
      get '/api/v1/tourist_sights'

      expect(response).to be_successful
      expect(response).to have_http_status(200)
  
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:data)
      expect(body[:data]).to be_an(Array)
  
      tourist_sight = body[:data].first

      expect(tourist_sight[:attributes][:address]).to include("Latvia")
    end

    it 'returns an error if the country provided is not valid', vcr: {cassette_name: 'all countries'} do
      get '/api/v1/tourist_sights?country=genovia'

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to be_an Array
      expect(body[:errors].first).to eq({
        title: "Invalid Parameters",
        details: "The country provided cannot be found.",
        source: {parameter: 'country'}
      })
    end

    it 'returns the same error if the country parameter is blank', vcr: {cassette_name: 'all countries'} do
      get '/api/v1/tourist_sights?country='

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to be_an Array
      expect(body[:errors].first).to eq({
        title: "Invalid Parameters",
        details: "The country provided cannot be found.",
        source: {parameter: 'country'}
      })
    end

  end


end