class V1::OwnedResource < V1::BaseResource
	attribute :created_by, type: :string
	abstract
	before_create :set_created_by
	

	# def meta(options)
	# 	super.merge(created_by: _model.created_by)
	# end

	def self.creatable_fields(context)
	   if context[:current_user].admin?
	       super(context)
	   else
	   	   super(context) - [:created_by]
	   end
	end

	def self.updateable_fields(context)
		if context[:current_user].admin?
			super(context)
		else
			super(context) - [:created_by]
		end
	end

	private 
	def set_created_by
		_model.created_by = context[:current_user].id
	end
end