module Types
  class CategoryType < Types::BaseObject
  	field :id, ID, null: false
  	field :name, String, null: true
  	field :description, String, null: true
  end
end
