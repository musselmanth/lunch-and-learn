class Api::V1::TouristSightsController < ApplicationController
  def index
    country = params[:country] || CountriesFacade.random_country
    coordinates = CountriesFacade.capital_latlong(country)
    tourist_sights = TouristSightsFacade.by_coordinates(coordinates)
    render json: TouristSightSerializer.new(tourist_sights)
  end
end