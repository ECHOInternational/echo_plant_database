class V1::BaseResource < JSONAPI::Resource
	abstract
	def meta(options)
		{
			requested_language: I18n.locale,
			available_languages: _model.try(:translations).try(:pluck, 'locale')
		}
	end

	def self.creatable_fields(context)
	    super << :id
	end
end