class Category < ApplicationRecord
	has_paper_trail
	translates :name, :description, versioning: :paper_trail, touch: true
end
