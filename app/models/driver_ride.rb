class DriverRide < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  has_many :passenger_rides
end
