module Mutations
	class UpdateCategory < BaseMutation
		argument :category_id, ID, required: true, loads: Types::CategoryType

		argument :name, String, required: false
		argument :description, String, required: false
		argument :language, String, required: false

		type Types::CategoryType

		def authorized?(category:, **attributes)
			authorize category, :update?
		end

		def resolve(category:, **attributes)
			language = attributes[:language] || I18n.locale

			attributes.except!(:language)

			Globalize.with_locale(language) do
				category.update!(attributes)
			end
			category
		end
	end
end