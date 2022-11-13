class Api::V1::LearningResourcesController < ApplicationController
  def index
    if params[:country].blank?
      render json: ErrorSerializer.required_parameter("country"), status: :bad_request
    else
      learning_resource = LearningResourcesFacade.by_country(params[:country])
      render json: LearningResourceSerializer.new(learning_resource)
    end
  end
end