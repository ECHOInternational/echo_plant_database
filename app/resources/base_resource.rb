class BaseResource < JSONAPI::Resource
	abstract
	key_type :uuid
	def meta(options)
		{
			requested_language: I18n.locale,
			available_languages: _model.try(:translations).try(:pluck, 'locale')
		}
	end
end