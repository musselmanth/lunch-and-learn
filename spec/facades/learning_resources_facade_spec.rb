require 'rails_helper'

RSpec.describe LearningResourcesFacade do
  it 'returns a learning resource object for a particular country', vcr: {cassette_name: 'laos images and video' } do
    learning_resource = LearningResourcesFacade.by_country("laos")
    expect(learning_resource).to be_instance_of(LearningResource)
    expect(learning_resource.country).to eq("laos")
    expect(learning_resource.id).to be nil
    expect(learning_resource.video[:title]).to be_a String
    expect(learning_resource.video[:youtube_video_id]).to be_a String
    expect(learning_resource.images).to be_an Array

    first_image = learning_resource.images.first

    expect(first_image[:alt_tag]).to be_a String
    expect(first_image[:url]).to be_a String
  end
end