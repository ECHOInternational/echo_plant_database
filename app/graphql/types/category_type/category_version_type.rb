module Types
  class CategoryType
    class CategoryVersionType < Types::BaseObject
    	global_id_field :id

    	description "A version of a category"

      field :user, String, "The user that made the changes in a version", null: true, method: :whodunnit
    	field :name, String, "The translated name of a category as it appears in a version", null: true
    	field :description, String, "A translated description of a category as it appears in a version", null: true
      field :locale, String, "The language of the version", null: true
      field :date, GraphQL::Types::ISO8601DateTime, "The date the version was created", null: false, method: :created_at
      
      def name
        return @object.reify.name || '' if @object.reify
      end
      def description
        return @object.reify.description || '' if @object.reify
      end
    end
  end
end