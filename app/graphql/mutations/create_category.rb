module Mutations
	class CreateCategory < BaseMutation
		argument :name, String, required: true
		argument :description, String, required: false
		argument :language, String, required: false

		type Types::CategoryType

		def authorized?(**attributes)
			authorize Category, :create?
		end

		def resolve(**attributes)
			language = attributes[:language] || I18n.locale

			attributes.
				except!(:language).
				merge!(created_by: context[:current_user])

			Globalize.with_locale(language) do
				Category.create!(attributes)
			end
		end
	end
end