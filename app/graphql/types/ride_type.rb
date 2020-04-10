module Types
  class RideType < Types::BaseObject
    description "Ride"
    field :id, Integer, null: false
    field :departure, String, null: false
    field :arrival, String, null: false
    field :driver_rides, [Types::DriverRideType], null: true
    field :passenger_rides, [Types::PassengerRideType], null: true
  end
end
