class ImageAttribute < ApplicationRecord
	has_paper_trail
	translates :name, versioning: {gem: :paper_trail, options: {touch: true, on: [:update] }}
	validates :name, presence: true
	has_many :image_attributes_image
	has_many :images, through: :image_attributes_image, dependent: :destroy
end
