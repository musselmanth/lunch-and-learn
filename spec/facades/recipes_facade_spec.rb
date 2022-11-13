require 'rails_helper'

RSpec.describe RecipesFacade do
  it 'returns array of recipe poros for a country', vcr: {cassette_name: 'greek recipes'} do
    recipes = RecipesFacade.by_country("greece")
    expect(recipes).to be_an(Array)
    recipes.each do |recipe|
      expect(recipe).to be_instance_of(Recipe)
      expect(recipe.title).to be_a(String)
      expect(recipe.url).to be_a(String)
      expect(recipe.image).to be_a(String)
      expect(recipe.country).to be_a(String)
    end
  end
end