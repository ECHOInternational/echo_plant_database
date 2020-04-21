module Mutations
	class DeleteCategory < BaseMutation
		argument :category_id, ID, required: true, loads: Types::CategoryType

		field :category_id, ID, null: false

		def authorized?(category:)
			authorize category, :destroy?
		end

		def resolve(category:)
			id_to_return = EchoPlantDatabaseSchema.id_from_object(category, Types::CategoryType, context)
			category.destroy!
			{
				category_id: id_to_return
			}
		end
	end
end