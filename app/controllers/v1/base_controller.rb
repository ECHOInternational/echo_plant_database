class V1::BaseController < ApplicationController
	include JSONAPI::ActsAsResourceController

	rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
 	def record_not_unique
 		render json: {errors: [status: "Conflict", message: "ID: #{params[:data][:id]} is already taken."]}, :status => 409
	end
end