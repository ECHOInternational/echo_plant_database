module Types
	class CategoryInput < Types::BaseInputObject
		description "Attributes for creating or updating a plant category"
		argument :name, String, "The name of the category", required: true
		argument :description, String, "A description of the category", required: false
		argument :language, String, "A lowercase two-letter code representing the language of attributes being submitted", required: false
	end
end