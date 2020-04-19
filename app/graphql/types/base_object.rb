module Types
  class BaseObject < GraphQL::Schema::Object
  	implements GraphQL::Types::Relay::Node
  end
end
