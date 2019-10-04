class User
	extend ActiveModel::Naming
	attr_reader :id
	attr_reader :email
	attr_reader :permissions

	def initialize(options)
		@id = options["uid"]
		@email = options["email"]
		@permissions = options["trust_levels"]
	end

	def to_model
	end

	def to_s
		@id
	end

	def inspect
		@id
	end

	def persisted?
		false
	end
end