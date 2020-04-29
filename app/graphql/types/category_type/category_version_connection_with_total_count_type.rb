module Types
	class CategoryType
		class CategoryVersionConnectionWithTotalCountType < GraphQL::Types::Relay::BaseConnection
		    edge_type(CategoryVersionEdgeType)

		    field :total_count, Integer, null: false
		    def total_count
		      object.items.size
		    end
		  end
	end
end