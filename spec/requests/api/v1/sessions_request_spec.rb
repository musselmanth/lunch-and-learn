require 'rails_helper'

RSpec.describe 'Sessions Requests' do
  
  let!(:headers) { {"CONTENT_TYPE" => "application/json"} }

  describe 'happy path' do
    it 'logs in a user when a valid email and password are sent' do
      user = create(:user)
      payload = JSON.generate(
        {
          email: user.email,
          password: "test123"
        }
      )

      post '/api/v1/sessions', headers: headers, params: payload

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data][:id]).to eq(user.id.to_s)
      expect(body[:data][:type]).to eq("user")
      expect(body[:data][:attributes]).to be_a Hash
      expect(body[:data][:attributes].length).to eq(3)
  
      attributes = body[:data][:attributes]
  
      expect(attributes[:name]).to eq(user.name)
      expect(attributes[:email]).to eq(user.email)
      expect(attributes[:api_key]).to eq(user.api_key)
    end
  end

  describe 'sad path' do
    it 'returns error when password is incorrect' do
      user = create(:user)
      payload = JSON.generate(
        {
          email: user.email,
          password: "test124"
        }
      )

      post '/api/v1/sessions', headers: headers, params: payload

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:errors]).to be_an Array
      expect(body[:errors].length).to eq(1)
      expect(body[:errors].first[:detail]).to eq("The email or password provided is invalid.")
    end

    it 'returns error when email is incorrect' do
      user = create(:user)
      payload = JSON.generate(
        {
          email: 'bad_email@test.com',
          password: "test123"
        }
      )

      post '/api/v1/sessions', headers: headers, params: payload

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:errors]).to be_an Array
      expect(body[:errors].length).to eq(1)
      expect(body[:errors].first[:detail]).to eq("The email or password provided is invalid.")
    end
  end
end