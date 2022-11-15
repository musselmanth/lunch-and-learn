class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      favorite = user.favorites.new(favorite_params)
      if favorite.save
        render json: {success: "Favorite added successfully"}, status: :created
      else
        render json: ErrorSerializer.validation_errors(favorite.errors), status: :bad_request
      end
    else
      render json: ErrorSerializer.user_not_found, status: :not_found
    end
  end

  def index
    user = User.find_by(api_key: params[:api_key])
    if user
      favorites = user.favorites
      render json: FavoriteSerializer.new(favorites)
    else
      render json: ErrorSerializer.user_not_found, status: :not_found
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
  end

  private

  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end