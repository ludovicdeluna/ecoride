class PassengerRide < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  belongs_to :driver_ride, optional: true
end
