require 'rails_helper'

RSpec.describe 'Favorites Requests' do

  let!(:headers) { {"CONTENT_TYPE" => "application/json"} }

  describe 'post favorite' do

    describe 'happy path' do

      it 'post /api/v1/favorites' do
        user = create(:user)

        payload = JSON.generate({
          "api_key": user.api_key,
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/recipe1",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        })

        post '/api/v1/favorites', headers: headers, params: payload

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        new_favorite = Favorite.last
        expect(user.favorites).to eq([new_favorite])
        expect(new_favorite.country).to eq("thailand")
        expect(new_favorite.recipe_link).to eq("https://www.tastingtable.com/recipe1")
        expect(new_favorite.recipe_title).to eq("Crab Fried Rice (Khaao Pad Bpu)")

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body.length).to eq(1)
        expect(body[:success]).to eq("Favorite added successfully")
      end
    end
  end
end