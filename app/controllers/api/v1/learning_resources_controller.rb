class Api::V1::LearningResourcesController < ApplicationController
  def index
    if params[:country].blank?
      render json: ErrorSerializer.required_parameter("country"), status: :bad_request
    elsif CountriesFacade.valid_country?(params[:country])
      learning_resource = LearningResourcesFacade.by_country(params[:country])
      render json: LearningResourceSerializer.new(learning_resource)
    else
      render json: ErrorSerializer.invalid_country, status: :not_found
    end
  end
end