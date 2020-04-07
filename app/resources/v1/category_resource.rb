class V1::CategoryResource < V1::OwnedResource
	attribute :name, type: :string
	attribute :description, type: :string
	relationship :images, to: :many
end