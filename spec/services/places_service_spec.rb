require 'rails_helper'

RSpec.describe PlacesService do
  it 'returns a response with a collection of features', vcr: {cassette_name: 'paris tourist sites'} do
    response = PlacesService.get_tourist_sites(long: 2.33, lat: 48.87)

    expect(response).to be_a Hash
    expect(response[:type]).to eq("FeatureCollection")
    expect(response[:features]).to be_an Array
    
    features = response[:features]

    features.each do |feature|
      expect(feature).to have_key(:properties)
      
      properties = feature[:properties]
      
      expect(properties[:name]).to be_a String
      expect(properties[:address_line1]).to be_a String
      expect(properties[:address_line2]).to be_a String
      expect(properties[:place_id]).to be_a String
    end
  end

  it 'has same format for a differenct country', vcr: {cassette_name: 'wellington tourist sites'} do
    response = PlacesService.get_tourist_sites(long: 174.78, lat: -41.3)
    
    expect(response).to be_a Hash
    expect(response[:type]).to eq("FeatureCollection")
    expect(response[:features]).to be_an Array
    
    features = response[:features]

    features.each do |feature|
      expect(feature).to have_key(:properties)
      
      properties = feature[:properties]
      
      expect(properties[:name]).to be_a String
      expect(properties[:address_line1]).to be_a String
      expect(properties[:address_line2]).to be_a String
      expect(properties[:place_id]).to be_a String
    end
  end
end