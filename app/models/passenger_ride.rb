class PassengerRide < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  belongs_to :driver_ride, optional: true

  validate :same_network, on: :create

  def same_network
    errors.add(:network, "must be on the same network") unless user.network_id == ride.network_id
  end
end
