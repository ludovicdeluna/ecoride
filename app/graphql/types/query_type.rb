module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false, description: "An user"
    def users
      User.where(network_id: context[:network_id]).all
    end
  end
end
