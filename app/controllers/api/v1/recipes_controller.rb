class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country]
    recipes = RecipesFacade.by_country(country)
    render json: RecipeSerializer.new(recipes)
  end
end