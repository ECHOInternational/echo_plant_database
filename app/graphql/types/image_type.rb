module Types
  class ImageType < Types::BaseObject
  	global_id_field :id
  	field :uuid, ID, null: false, method: :id
  	field :name, String, null: false
  	field :description, String, null: true
  	field :base_url, String, null: false
  	field :attribution, String, null: true
  	field :image_attributes, [Types::ImageAttributeType], null: true
  end
end
