class YoutubeService
  
  def self.get_mr_history_videos(country)
    response = connection.get("/youtube/v3/search", {
      channelId: 'UCluQ5yInbeAkkeCndNnUhpw',
      part: 'snippet',
      maxResults: '25',
      q: country
    })
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.connection
    Faraday.new(url: 'https://youtube.googleapis.com', params: {key: ENV['google_api_key']})
  end
end