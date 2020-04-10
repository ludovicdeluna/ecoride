module Mutations
  class ShareRideMutation < Mutations::BaseMutation
    description "A passenger goes with a driver"

    argument :driver_ride_id, ID, "The id of the driver ride", required: true
    argument :passenger_ride_id, ID, "The id of the passenger ride", required: true

    field :passenger_ride, Types::PassengerRideType, "The updated passenger ride", null: true
    field :errors, [String], "The list of errors if it failed. Empty if succeed.", null: true

    def resolve(passenger_ride_id:, **options)
      passenger_ride = PassengerRide.find(passenger_ride_id)
      if passenger_ride.update(**options)
        {
          passenger_ride: passenger_ride,
          errors: []
        }
      else
        {
          passenger_ride: nil,
          errors: passenger_ride.errors.full_messages
        }
      end
    end
  end
end
