class Network < ApplicationRecord
  has_many :rides
  has_many :users
end
