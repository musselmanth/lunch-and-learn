class PlacesService

  def self.get_tourist_sites(lat, long)
    response = connection.get('/v2/places', {
      name: '',
      categories: ''
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