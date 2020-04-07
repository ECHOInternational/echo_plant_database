class V1::BaseResource < JSONAPI::Resource
	abstract
	include JSONAPI::Authorization::PunditScopedResource

	def meta(options)
		{
			requested_language: I18n.locale,
			available_languages: _model.try(:translations).try(:pluck, 'locale'),
			created_at: _model.created_at,
			updated_at: _model.updated_at,
		}
	end

	def self.creatable_fields(context)
	   if context[:current_user].super_admin?
	       super(context) << :id
	   else
	   	   super(context)
	   end
	end
end
