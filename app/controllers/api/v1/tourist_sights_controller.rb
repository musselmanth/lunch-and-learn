class Api::V1::TouristSightsController < ApplicationController
  def index
    country = params[:country] || CountriesFacade.random_country
    if CountriesFacade.valid_country?(country)
      coordinates = CountriesFacade.capital_latlong(country)
      tourist_sights = TouristSightsFacade.by_coordinates(coordinates)
      render json: TouristSightSerializer.new(tourist_sights)
    else
      render json: ErrorSerializer.invalid_country, status: :not_found
    end
  end
end