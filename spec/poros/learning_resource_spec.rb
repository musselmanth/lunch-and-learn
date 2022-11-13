require 'rails_helper'

RSpec.describe LearningResource do
  let!(:video_data) { {id: {videoId: "abcdefg"}, snippet: {title: "test video"}} }
  let!(:images_data) {[
    {alt_description: "image_1 desc", urls: {regular: "https://test.image.path/1.png"}},
    {alt_description: "image_2 desc", urls: {regular: "https://test.image.path/2.png"}},
    {alt_description: "image_3 desc", urls: {regular: "https://test.image.path/3.png"}}
  ]}
  let!(:country) { "laos" }

  it 'exists and has attributes' do
    new_learning_resource = LearningResource.new(video_data, images_data, country)
    
    expect(new_learning_resource).to be_instance_of LearningResource
    expect(new_learning_resource.id).to be nil
    expect(new_learning_resource.country).to eq("laos")
    expect(new_learning_resource.video).to eq({title: "test video", youtube_video_id: "abcdefg"})
    expect(new_learning_resource.images).to be_an Array
    expect(new_learning_resource.images.length).to eq(3)

    first_image = new_learning_resource.images.first
    
    expect(first_image).to eq ({alt_tag: "image_1 desc", url: "https://test.image.path/1.png"})
  end
end