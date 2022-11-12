require 'rails_helper'

RSpec.describe RecipesService do
  it 'returns recipes for a country', vcr: {cassette_name: 'greek recipes'} do
    recipes = RecipesService.get_recipes("greece")
    
    expect(recipes).to be_a(Hash)
    expect(recipes).to have_key(:hits)
    expect(recipes[:hits]).to be_an(Array)

    first_recipe = recipes[:hits].first
    expect(first_recipe).to be_a(Hash)
    expect(first_recipe).to have_key(:recipe)
    expect(first_recipe[:recipe]).to have_key(:label)
    expect(first_recipe[:recipe][:label]).to be_a(String)
    expect(first_recipe[:recipe]).to have_key(:image)
    expect(first_recipe[:recipe][:image]).to be_a(String)
    expect(first_recipe[:recipe]).to have_key(:url)
    expect(first_recipe[:recipe][:url]).to be_a(String)
  end
end