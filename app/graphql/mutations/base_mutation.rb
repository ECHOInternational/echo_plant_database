module Mutations
	class BaseMutation < GraphQL::Schema::Mutation
		include Pundit
		def pundit_user
			context[:current_user]
		end
		
		null false
	end
end