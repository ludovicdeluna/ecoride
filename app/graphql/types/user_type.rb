module Types
  class UserType < Types::BaseObject
    description "User"
    field :id, Integer, null: false
    field :email, String, null: false
    field :driver_rides, [Types::DriverRideType], null: true
    field :passenger_rides, [Types::PassengerRideType], null: true
  end
end
