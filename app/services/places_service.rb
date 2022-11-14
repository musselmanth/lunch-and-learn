class PlacesService

  def self.get_tourist_sites(coordinates)
    response = connection.get('/v2/places', {
      filter: "circle:#{coordinates[:long]},#{coordinates[:lat]},20000",
      categories: 'tourism.sights'
    })
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.connection
    Faraday.new(url: 'https://api.geoapify.com', params: {
      apiKey: ENV['geoapify_api_key']
    })
  end

end