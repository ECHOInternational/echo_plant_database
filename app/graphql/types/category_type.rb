module Types
  class CategoryType < Types::BaseObject
  	field :id, ID, null: false
  	field :name, String, null: true
  	field :description, String, null: true
  	field :created_by, String, null: true
  	field :images, [Types::ImageType], null: true
  end
end
