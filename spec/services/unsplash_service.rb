require 'rails_helper'

RSpec.describe UnsplashService do
  it 'returns images for a given search', vcr: {cassette_name: 'laos images search'} do
    response = UnsplashService.get_image_search("laos")

    expect(response).to be_a Hash
    expect(response).to have_key(:results)
    expect(response[:results]).to be_an Array

    response[:results].each do |image|
      expect(image[:alt_description]).to be_a String
      expect(image[:urls][:regular]).to be_a String
    end
  end
end