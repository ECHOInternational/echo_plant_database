require 'search_object'
require 'search_object/plugin/graphql'

module Resolvers
	class CategoriesResolver < Resolvers::BaseResolver
	  include SearchObject.module(:graphql)
	  type Types::CategoryType::CategoryConnectionWithTotalCountType, null: false
	  description "Returns a list of Plant Categories"

	  class SortDirectionEnum < Types::BaseEnum
	  	graphql_name 'SortDirection'
	  	description 'Sets the direction returned records will be sorted'
	  	value 'ASC', value: :asc, description: "Ascending Order"
	  	value 'DESC', value: :desc, description: "Descending Order"
	  end

	  class OwnershipEnum < Types::BaseEnum
	  	graphql_name 'Ownership'
	  	description 'Returns records based on ownership'
	  	value 'USER', value: :user, description: "Request only records that belong to the current user"
	  	value 'PUBLIC', value: :public, description: "Request only records that are public"
	  	value 'ALL', value: :all, description: "Request both public records, and records that belong to the current user"
	  end

	  scope {Pundit.policy_scope(context[:current_user], Category)}

	  option :language, type: types.String, with: :apply_language_filter, description: "Request returned fields in a specific languge. Overrides ACCEPT-LANGUAGE header."
	  option :name, type: types.String, with: :apply_name_filter, description: "Performs a case-insensitive LIKE match on the name field"
	  option :owned_by, type: OwnershipEnum, default: :all
	  option :sort_direction, type: SortDirectionEnum, default: :asc, description: "Sorts by name either ascending or descending"

	  def apply_owned_by_with_user(scope)
	  	scope.where(created_by: context[:current_user].id)
	  end

	  def apply_owned_by_with_public(scope)
	  	scope.where(created_by: "public")
	  end

	  def apply_owned_by_with_all(scope)
	  	scope
	  end

	  def apply_sort_direction_with_asc(scope)
	  	scope.order(name: :asc)
	  end

	  def apply_sort_direction_with_desc(scope)
	  	scope.order(name: :desc)
	  end

	 def apply_name_filter(scope, value)
	 	return scope if value.blank?
	 	scope.joins(:translations).where('category_translations.name iLIKE ?', "%#{value}%")
	 end

	 def apply_language_filter(scope, value)
	 	# the language is actually applied in the fetch results method
	 	scope
	 end

	  
	  def fetch_results
	  	# Set the requested language
	  	I18n.locale = language if language
	  	# Because we're "including"  the translations we can get duplicates, eliminate them before returning.
	    super.uniq
	  end

	end
end
