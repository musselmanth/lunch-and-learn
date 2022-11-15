class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country] || CountriesFacade.random_country
    if CountriesFacade.valid_country?(country)
      recipes = RecipesFacade.by_country(country)
      render json: RecipeSerializer.new(recipes)
    else
      render json: ErrorSerializer.invalid_country, status: :not_found
    end
  end
end