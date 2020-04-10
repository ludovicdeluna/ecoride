module Types
  class PassengerRideType < Types::BaseObject
    description "PassengerRide"
    field :id, Integer, null: false
    field :user, Types::UserType, null: false
    field :ride, Types::RideType, null: false
    field :driver_ride, Types::DriverRideType, null: true
  end
end
