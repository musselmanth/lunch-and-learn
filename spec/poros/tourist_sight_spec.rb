require 'rails_helper'

RSpec.describe TouristSight do
  it 'exists and has attributes' do
    ts_data = {properties: {name: "test name", address_line1: "123 Main St.", address_line2: "City, ST 00000", place_id: "12345"}}
    sight = TouristSight.new(ts_data)
    expect(sight).to be_instance_of TouristSight
    expect(sight.name).to eq("test name")
    expect(sight.address).to eq("123 Main St., City, ST 00000")
    expect(sight.place_id).to eq("12345")
    expect(sight.id).to be nil
  end
end

