class Api::V1::LearningResourcesController < ApplicationController
  def index
    country = params[:country]
    learning_resource = LearningResourcesFacade.by_country(country)
    render json: LearningResourceSerializer.new(learning_resource)
  end
end