class TouristSightFacade
  
  def self.by_coordinates(coordinates)
    tourist_sights_data = PlacesService.get_tourist_sites(coordinates)[:features]
    tourist_sights_data.map{ |sight_data| TouristSight.new(sight_data) }
  end

end