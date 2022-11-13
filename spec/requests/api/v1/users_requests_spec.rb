require 'rails_helper'

RSpec.describe 'users requests' do
  let!(:headers) { {"CONTENT_TYPE" => "application/json"} }
  before :each do
    allow(SecureRandom).to receive(:hex).and_return("3897173252efebea6116d261f27c1462")
  end

  it 'posts new user happy path' do
    post '/api/v1/users', headers: headers, params: file_fixture("happy_user.json").read

    expect(response).to be_successful
    expect(response).to have_http_status(201)

    new_user = User.last
    expect(new_user.email).to eq("athenadao@bestgirlever.com")
    expect(new_user.api_key).to eq("3897173252efebea6116d261f27c1462")
    expect(new_user.name).to eq("Athena Dao")

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data][:id]).to eq(new_user.id)
    expect(body[:data][:type]).to eq("user")
    expect(body[:data][:attributes]).to be_a Hash
    expect(body[:data][:attributes].length).to eq(3)

    attributes = body[:data][:attributes]

    expect(attributes[:name]).to eq(new_user.name)
    expect(attributes[:email]).to eq(new_user.email)
    expect(attributes[:api_key]).to eq(new_user.api_key)
  end
end