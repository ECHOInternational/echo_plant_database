class EchoPlantDatabaseSchema < GraphQL::Schema
	use GraphQL::Pagination::Connections
	mutation(Types::MutationType)
	query(Types::QueryType)

	# You'll also need to define `resolve_type` for
	# telling the schema what type Relay `Node` objects are
	def self.resolve_type(type, obj, ctx)
		case obj
		when Category
			Types::CategoryType
		when Image
			Types::ImageType
		when ImageAttribute
			Types::ImageAttribute
		when Upload
			Types::Upload
		else
		  raise("Unexpected object: #{obj}")
		end
	end

	# Create UUIDs by joining the type name & ID, then base64-encoding it
	def self.id_from_object(object, type_definition, query_ctx)
		GraphQL::Schema::UniqueWithinType.encode(type_definition.graphql_name, object.id)
	end

	def self.object_from_id(id, query_ctx)
		type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
		Object.const_get(type_name).find(item_id);
	end
end
