require 'rails_helper'

RSpec.describe 'users requests' do
  let!(:headers) { {"CONTENT_TYPE" => "application/json"} }

  it 'posts new user happy path' do
    post '/api/v1/users', headers: headers, params: file_fixture("happy_user.json").read

    expect(response).to be_successful
    expect(response).to have_http_status(201)

    new_user = User.last
    expect(new_user.email).to eq("athenadao@bestgirlever.com")
    expect(new_user.name).to eq("Athena Dao")

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data][:id]).to eq(new_user.id.to_s)
    expect(body[:data][:type]).to eq("user")
    expect(body[:data][:attributes]).to be_a Hash
    expect(body[:data][:attributes].length).to eq(3)

    attributes = body[:data][:attributes]

    expect(attributes[:name]).to eq(new_user.name)
    expect(attributes[:email]).to eq(new_user.email)
    expect(attributes[:api_key]).to eq(new_user.api_key)
  end

  describe 'sad path' do
    it 'returns validation errors if the user is not valid' do
      post '/api/v1/users', headers: headers, params: file_fixture("sad_user.json").read

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:errors)

      name_error = body[:errors][0]
      email_error = body[:errors][1]
      email_confirm_error = body[:errors][2]

      expect(name_error[:title]).to eq("Invalid Attribute")
      expect(name_error[:detail]).to eq("Name can't be blank.")

      expect(email_error[:title]).to eq("Invalid Attribute")
      expect(email_error[:detail]).to eq("Email can't be blank.")

      expect(email_confirm_error[:title]).to eq("Invalid Attribute")
      expect(email_confirm_error[:detail]).to eq("Password Confirmation doesn't match Password.")
    end

    it 'returns errors with a missing body' do
      post '/api/v1/users', headers: headers

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)

      body = JSON.parse(response.body, symbolize_names: true)

      name_error = body[:errors][0]
      email_error = body[:errors][1]
      email_confirm_error = body[:errors][2]

      expect(name_error[:title]).to eq("Invalid Attribute")
      expect(name_error[:detail]).to eq("Name can't be blank.")

      expect(email_error[:title]).to eq("Invalid Attribute")
      expect(email_error[:detail]).to eq("Email can't be blank.")

      expect(email_confirm_error[:title]).to eq("Invalid Attribute")
      expect(email_confirm_error[:detail]).to eq("Password can't be blank.")
    end

  end
end