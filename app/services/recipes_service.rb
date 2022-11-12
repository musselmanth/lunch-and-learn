class RecipesService

  def self.get_recipes(country)
    response = connection.get("/api/recipes/v2", {q: country, type: "public"})
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.connection
    Faraday.new(url: "https://api.edamam.com", params: { 
      app_id: ENV['edamam_app_id'],
      app_key: ENV['edamam_app_key']
    })
  end

end