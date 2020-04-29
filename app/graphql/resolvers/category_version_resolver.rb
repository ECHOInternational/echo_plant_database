require 'search_object'
require 'search_object/plugin/graphql'

module Resolvers
	class CategoryVersionResolver < Resolvers::BaseResolver
	  include SearchObject.module(:graphql)
	  type Types::CategoryVersionType.connection_type, null: false
	  description 'Lists versions of a category'

	  class EventEnum < Types::BaseEnum
	  	graphql_name 'VersionEvent'
	  	value 'CREATE', value: "create"
	  	value 'UPDATE', value: "update"
	  	value 'DELETE', value: "delete"
	  end

	  scope { object.versions }

	  option :event, type: [EventEnum], default: ["update"]

	  def apply_event_filter(scope, value)
		scope.where event: value
      end

	end
end
