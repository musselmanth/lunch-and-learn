require 'rails_helper'

RSpec.describe 'Learning Resource Requests' do
  describe 'happy path'

  it 'returns a learning resource with video and image attributes', vcr: {cassette_name: 'laos images and video'} do
    get '/api/v1/learning_resources?country=laos'

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)

    learning_resource = body[:data]
    
    expect(learning_resource[:id]).to be nil
    expect(learning_resource[:type]).to eq("learning_resource")
    expect(learning_resource[:attributes]).to be_a Hash
    expect(learning_resource[:attributes].length).to eq(3)
    expect(learning_resource[:attributes][:country]).to eq("laos")
    expect(learning_resource[:attributes][:video]).to be_a Hash
    expect(learning_resource[:attributes][:video][:title]).to be_a String
    expect(learning_resource[:attributes][:video][:youtube_video_id]).to be_a String
    expect(learning_resource[:attributes][:images]).to be_an Array

    expect(learning_resource[:attributes][:images]).to_not be_empty

    learning_resource[:attributes][:images].each do |image|
      expect(image).to be_a Hash
      expect(image[:alt_tag]).to be_a String
      expect(image[:url]).to be_a String
    end
  end

  it 'returns an error if no country provided' do
    get '/api/v1/learning_resources'

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)

    errors = JSON.parse(response.body, symbolize_names: true)
    expect(errors).to be_a Hash
    expect(errors[:title]).to eq("Invalid Parameters")
    expect(errors[:detail]).to eq("A country parameter is required for this request.")
    expect(errors[:source]).to eq({parameter: "country"})
  end

  it 'returns an error if country parameter is blank' do
    get '/api/v1/learning_resources?country='

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)

    errors = JSON.parse(response.body, symbolize_names: true)
    expect(errors).to be_a Hash
    expect(errors[:title]).to eq("Invalid Parameters")
    expect(errors[:detail]).to eq("A country parameter is required for this request.")
    expect(errors[:source]).to eq({parameter: "country"})
  end
end