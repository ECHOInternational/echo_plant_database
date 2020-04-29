class Category < ApplicationRecord
	has_paper_trail
	translates :name, :description, versioning: :paper_trail
	validates :name, presence: true
	include Imageable
end
