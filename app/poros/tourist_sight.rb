class TouristSight

  attr_reader :id, :name, :address, :place_id

  def initialize(ts_data)
    @id = nil
    @name = ts_data[:properties][:name]
    @address = "#{ts_data[:properties][:address_line1]}, #{ts_data[:properties][:address_line2]}"
    @place_id = ts_data[:properties][:place_id]
  end
end