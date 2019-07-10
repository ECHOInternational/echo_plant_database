module API
	module V1
		class Categories < Grape::API
			include API::V1::Defaults
			resource :categories do
				desc 'Return a list of plant categories'
				get do
					categories = Category.all
					render categories
				end

				desc 'Return a plant category'
				params do
					requires :id, type: String, desc: 'Category UUID'
				end
				route_param :id do
					get do
						category = Category.find(params[:id])
						render category
					end
				end

				desc 'Create a plant category'
				params do
					requires :name, type: String, desc: 'New plant category name'
					requires :description, type: String, desc: 'New plant category description'
				end
				post do
					Category.new({
						name: params[:name],
						description: params[:description]
					}).save
				end
			end
		end
	end
end