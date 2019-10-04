module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :categories,
      [Types::CategoryType],
      null: false,
      description: "Returns a list of Plant Categories"

    field :category, Types::CategoryType, null: true do
      description "Find a category by ID"
      argument :id, ID, required: true
    end

    def categories
      Category.all
    end
    def category(id:)
      Category.find(id)
    end
  end
end
