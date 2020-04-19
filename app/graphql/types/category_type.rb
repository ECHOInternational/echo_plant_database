module Types
  class CategoryType < Types::BaseObject
  	global_id_field :id
  	field :uuid, ID, null: false, method: :id
  	field :name, String, null: true
  	field :description, String, null: true
  	field :created_by, String, null: true
  	field :images, Types::ImageType.connection_type, null: true
  end
end
