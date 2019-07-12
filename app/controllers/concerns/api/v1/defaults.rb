# app/controllers/concerns/api/v1/defaults.rb
module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1'
        format :json
        content_type :json, 'application/vnd.api+json'
        formatter :json, Grape::Formatter::JSONAPIResources
        # Errors
        default_error_formatter :json
        error_formatter :json, Grape::ErrorFormatter::Jsonapi
        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error! e, 400
        end
      end
    end
  end
end