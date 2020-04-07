JSONAPI.configure do |config|
	# Pagination
 	config.default_paginator = :paged
 	config.default_page_size = 10
 	config.maximum_page_size = 20

 	# Use UUIDS everywhere (this can be overridden at the controller level)
 	config.resource_key_type = :uuid

	config.json_key_format = :underscored_key
 	# Metadata
 	config.top_level_meta_include_record_count = true
 	config.top_level_meta_include_page_count = true

 	# TODO: Resource cache
	# An ActiveSupport::Cache::Store or similar, used by Resources with caching enabled.
	# Set to `nil` (the default) to disable caching, or to `Rails.cache` to use the
	# Rails cache store.
	config.resource_cache = nil

	config.default_processor_klass = JSONAPI::Authorization::AuthorizingProcessor

	config.exception_class_whitelist = [ActiveRecord::RecordNotUnique, Pundit::NotAuthorizedError]


end

JSONAPI::Authorization.configure do |config|
	config.pundit_user = :current_user
end