require 'rails_helper'

RSpec.describe Recipe do
  let!(:recipe_data) { {recipe: {label: "Test Recipe", url: "https://www.test.com", image: "https://www.test.com/image.png"}} }
  let!(:country) {"greece"}

  it 'exists and has attributes' do
    new_recipe = Recipe.new(recipe_data, country)
    expect(new_recipe).to be_instance_of(Recipe)
    expect(new_recipe.title).to eq("Test Recipe")
    expect(new_recipe.url).to eq("https://www.test.com")
    expect(new_recipe.image).to eq("https://www.test.com/image.png")
    expect(new_recipe.country).to eq("greece")
  end
end