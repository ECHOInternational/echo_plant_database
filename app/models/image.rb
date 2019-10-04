class Image < ApplicationRecord
	after_initialize :build_urls
	has_paper_trail
	translates :name, :description, versioning: {gem: :paper_trail, options: {touch: true, on: [:update] }}
	validates :name, presence: true
	attribute :base_url, :string
	attr_readonly :s3_bucket, :s3_key #These should not change once the record has been created
	has_many :image_attributes_image
	has_many :image_attributes, through: :image_attributes_image, dependent: :destroy
	belongs_to :imageable, polymorphic: true

	private
	def build_urls
		self.base_url = "https://images.echocommunity.org/#{self.s3_key}?w=400"
	end
end
