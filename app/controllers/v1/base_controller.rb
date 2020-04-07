class V1::BaseController < ApplicationController
	include JSONAPI::ActsAsResourceController
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
	rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

	def context
		{
			current_user: current_user,
			request_path: request.path
		}
	end

	private
 	def record_not_unique
 		render json: {errors: [status: "Conflict", message: "ID: #{params[:data][:id]} is already taken."]}, :status => 409
	end

	def user_not_authorized
		raise if Rails.env.development?
		head :forbidden
	end

end