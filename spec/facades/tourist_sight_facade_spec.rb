require 'rails_helper'

RSpec.describe TouristSightFacade do
  describe '#by_coordinates' do
    it 'returns an array of TouristSight POROs', vcr: {cassette_name: 'paris tourist sights'} do
      tourist_sights = TouristSightFacade.by_coordinates(long: 2.33, lat: 48.87)
      tourist_sights.each do |tourist_sight|
        expect(tourist_sight).to be_instance_of TouristSight
        expect(tourist_sight.id).to be nil
        expect(tourist_sight.name).to be_a String
        expect(tourist_sight.address).to be_a String
        expect(tourist_sight.place_id).to be_a String
      end
    end
  end
end