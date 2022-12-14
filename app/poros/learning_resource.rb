class LearningResource
  attr_reader :id, :country, :video, :images

  def initialize(video_data, images_data, country)
    @id = nil
    @country = country
    @video = video_data ? {
      title: video_data[:snippet][:title],
      youtube_video_id: video_data[:id][:videoId]
    } : {}
    @images = images_data.map do |image_data|
      {
        alt_tag: image_data[:alt_description],
        url: image_data[:urls][:regular]
      }
    end
  end
end