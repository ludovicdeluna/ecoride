module Types
  class DriverRideType < Types::BaseObject
    description "DriverRide"
    field :id, Integer, null: false
    field :user, Types::UserType, null: false
    field :ride, Types::RideType, null: false
    field :passenger_rides, [Types::PassengerRideType], null: true
  end
end
