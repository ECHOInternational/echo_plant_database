# app/controllers/concerns/api/v1/defaults.rb
module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1'
        format :json
        formatter :json, Grape::Formatter::JSONAPIResources
        content_type :json, 'application/vnd.api+json'
      end
    end
  end
end