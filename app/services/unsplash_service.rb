class UnsplashService

  def self.get_image_search(country)
    response = connection.get("/search/photos", {query: country})
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.connection
    Faraday.new(url: 'https://api.unsplash.com', params: {
      client_id: ENV['unsplash_access_key']
    })
  end
end