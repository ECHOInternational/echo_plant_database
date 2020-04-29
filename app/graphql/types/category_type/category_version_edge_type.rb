module Types
  class CategoryType
  	class CategoryVersionEdgeType < GraphQL::Types::Relay::BaseEdge
	    node_type(CategoryVersionType)
	end
  end
end