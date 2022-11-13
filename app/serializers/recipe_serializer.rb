class RecipeSerializer
  include JSONAPI::Serializer

  attributes :title, :image, :url, :country
end