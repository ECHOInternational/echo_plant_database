module Types
  class QueryType < Types::BaseObject
    # Used by Relay to lookup objects by UUID:
    add_field(GraphQL::Types::Relay::NodeField)
    # Fetches a list of objects given a list of IDs
    add_field(GraphQL::Types::Relay::NodesField)

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :categories, resolver: Resolvers::CategoriesResolver, connection: true

    field :category, Types::CategoryType, null: true do
      description "Find a category by ID"
      argument :id, ID, required: true
    end


    def category(id:)
      type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
      Pundit.policy_scope(context[:current_user], Category).find(item_id)
    end
  end
end