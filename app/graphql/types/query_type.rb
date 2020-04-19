module Types
  class QueryType < Types::BaseObject
    # Used by Relay to lookup objects by UUID:
    add_field(GraphQL::Types::Relay::NodeField)
    # Fetches a list of objects given a list of IDs
    add_field(GraphQL::Types::Relay::NodesField)

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :categories, Types::CategoryType.connection_type, null: false do
      description "Returns a list of Plant Categories"
      argument :scope, String, required: false, prepare: ->(scope, ctx) {
          raise GraphQL::ExecutionError.new("Invalid Scope Argument") unless ["user", "public", nil].include?(scope)
          scope
      } 
    end

    field :category, Types::CategoryType, null: true do
      description "Find a category by ID"
      argument :id, ID, required: true
    end

    def categories(scope: nil)
      case scope
        when "user"
          Pundit.policy_scope(context[:current_user], Category).where(created_by: context[:current_user].id)
        when "public"
          Pundit.policy_scope(context[:current_user], Category).where(created_by: "public")
        else
          Pundit.policy_scope(context[:current_user], Category)
        end 
    end

    def category(id:)
      type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
      Pundit.policy_scope(context[:current_user], Category).find(item_id)
    end
  end
end
