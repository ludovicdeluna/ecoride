module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false, description: "An user"
    def users
      User.all
    end
  end
end
