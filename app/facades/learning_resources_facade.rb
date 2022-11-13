class LearningResourcesFacade
  def self.by_country(country)
    video_data = YoutubeService.get_mr_history_videos(country)[:items].first
    images_data = UnsplashService.get_image_search(country)[:results][0..9]
    LearningResource.new(video_data, images_data, country)
  end
end