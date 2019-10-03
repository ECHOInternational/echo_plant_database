Rails.application.routes.draw do
	post "/graphql", to: "graphql#execute"
	namespace :v1 do
		jsonapi_resources :categories
	end
end
