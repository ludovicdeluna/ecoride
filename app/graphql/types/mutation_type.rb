module Types
  class MutationType < Types::BaseObject
    field :create_driver_ride, mutation: Mutations::CreateDriverRideMutation
    field :create_passenger_ride, mutation: Mutations::CreatePassengerRideMutation
    field :share_ride, mutation: Mutations::ShareRideMutation
  end
end
