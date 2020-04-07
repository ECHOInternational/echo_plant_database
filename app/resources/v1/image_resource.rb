class V1::ImageResource < V1::OwnedResource
	attributes :name, :description, :attribution, :base_url, :s3_bucket, :s3_key
	relationship :imageable, polymorphic: true, to: :one

	# ID is required on create 
	def self.creatable_fields(context)
	       super(context) << :id
	end

	def self.updateable_fields(context)
		super(context) - [:s3_bucket, :s3_key]
	end


end

class V1::ImageableResource < JSONAPI::Resource; end