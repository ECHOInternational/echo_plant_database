class Upload
	extend ActiveModel::Naming
	attr_reader :id
	attr_reader :form_data
	attr_reader :expiration
	attr_reader :klass

	def initialize(model)

		@klass = model.name
		@id = SecureRandom.uuid
		@expiration = Time.now + 1.hour

		presigned_post = get_presigned_post

		@form_data = {
			action: presigned_post.url,
			method: "post",
			enctype: "multipart/form-data",
			fields: {
				hidden: presigned_post.fields,
				file: {file: nil}
			}
		}
	end

	def to_model
	end

	def persisted?
		false
	end

	private

	def get_presigned_post
		presigned_post_options = {
			signature_expiration: @expiration,
			key: "#{@id}/${filename}",
			success_action_status: '201'
		}
		s3 = Aws::S3::Resource.new
		bucket = s3.bucket(ENV["#{@klass.upcase}_BUCKET"])
		bucket.presigned_post(presigned_post_options)
	end

end