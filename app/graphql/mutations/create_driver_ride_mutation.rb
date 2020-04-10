module Mutations
  class CreateDriverRideMutation < Mutations::BaseMutation
    description "A driver declares he will drive trhough a ride"

    argument :user_id, ID, "The id of the driver", required: true
    argument :ride_id, ID, "The id of the ride", required: true

    field :driver_ride, Types::DriverRideType, "The created driver ride", null: true
    field :errors, [String], "The list of errors if it failed. Empty if succeed.", null: true

    def resolve(**options)
      passenger_ride = DriverRide.new(**options)
      if passenger_ride.save
        p passenger_ride
        {
          driver_ride: passenger_ride,
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
