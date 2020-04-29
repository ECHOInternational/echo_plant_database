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

	  scope {Pundit.policy_scope(context[:current_user], Category).includes(:translations)}

	  
	  option :name, type: types.String, with: :apply_name_filter
	  option :owned_by, type: OwnershipEnum, default: :all
	  option :sort_direction, type: SortDirectionEnum, default: :asc

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

	  # Because we're "including"  the translations we can get duplicates, eliminate them before returning.
	  def fetch_results
	    super.uniq
	  end

	end
end
