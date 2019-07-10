class Category < ApplicationRecord
	has_paper_trail
	translates :name, :description, versioning: {gem: :paper_trail, options: {touch: true, on: [:update] }}
	validates :name, presence: true
end
