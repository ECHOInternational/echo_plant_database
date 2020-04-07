# This resource returns an ID and the parameters
# necessary to upload a file to the API

class V1::UploadResource < JSONAPI::Resource
	immutable
	include JSONAPI::Authorization::PunditScopedResource

	attribute :form_data
	attribute :expiration

	exclude_links :default

	def self.find_by_key(key, options = {})
		context = options[:context]
		path = context[:request_path]
		
		model = Upload.new(parent_class_from_path(path))

		resource_for_model(model).new(model, context)
	end

	def custom_links(options)
		p = options[:serializer].link_builder.primary_resources_url
	    { post_url: p.gsub('upload', _model.klass.downcase) }
	end

	private 

	def self.parent_class_from_path(path)
		path_parts = path.split("/")
		upload_index = path_parts.find_index("upload")
		
		return nil unless upload_index

		parent = path_parts[upload_index - 1]

		return nil unless parent

		parent.singularize.capitalize.constantize

	end
end
