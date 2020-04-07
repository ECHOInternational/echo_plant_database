Rails.application.routes.draw do
	post "/graphql", to: "graphql#execute"
	namespace :v1 do
		jsonapi_resources :categories
		jsonapi_resources :images do
			collection do
				jsonapi_resource :upload
			end
		end
		# jsonapi_resource :upload
	end
end
