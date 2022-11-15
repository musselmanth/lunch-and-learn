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
    expect(learning_resource[:attributes][:images].length).to eq(10)

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

    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to be_a Hash
    expect(body[:errors]).to be_an Array
    expect(body[:errors].length).to eq(1)

    error = body[:errors].first

    expect(error[:title]).to eq("Invalid Parameters")
    expect(error[:detail]).to eq("A country parameter is required for this request.")
    expect(error[:source]).to eq({parameter: "country"})
  end

  it 'returns an error if country parameter is blank' do
    get '/api/v1/learning_resources?country='

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)

    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to be_a Hash
    expect(body[:errors]).to be_an Array
    expect(body[:errors].length).to eq(1)

    error = body[:errors].first

    expect(error[:title]).to eq("Invalid Parameters")
    expect(error[:detail]).to eq("A country parameter is required for this request.")
    expect(error[:source]).to eq({parameter: "country"})
  end

  it 'returns empty object for video if there are not results', vcr: {cassette_name: 'all countries'} do

    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['google_api_key']}&maxResults=25&part=snippet&q=bhutan")
      .to_return(body: file_fixture("empty_video_results.json").read)

    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['unsplash_access_key']}&query=bhutan")
      .to_return(body: file_fixture("empty_image_results.json").read)

    get '/api/v1/learning_resources?country=bhutan'

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    body = JSON.parse(response.body, symbolize_names: true)
    learning_resource = body[:data]

    expect(learning_resource[:attributes][:video]).to eq({})
    expect(learning_resource[:attributes][:images]).to eq([])
  end

  it 'returns an error if the country is not valid', vcr: {cassette_name: 'all countries'} do
    get '/api/v1/learning_resources?country=musselmanland'

    expect(response).to_not be_successful
    expect(response).to have_http_status(404)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:errors]).to be_an(Array)
    expect(body[:errors].length).to eq(1)
    expect(body[:errors].first[:detail]).to eq("The country provided cannot be found.")
  end
end