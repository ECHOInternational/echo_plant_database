module Types
  class ImageType < Types::BaseObject
  	field :name, String, null: false
  	field :description, String, null: true
  	field :base_url, String, null: false
  	field :attribution, String, null: true
  	field :image_attributes, [Types::ImageAttributeType], null: true
  end
end
