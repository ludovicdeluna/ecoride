class User < ApplicationRecord
  has_many :driver_rides
  has_many :passenger_rides

  validates :email, presence: true
end
