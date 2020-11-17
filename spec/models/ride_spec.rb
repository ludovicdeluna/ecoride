require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe "#validate_same_network" do

    subject { PassengerRide.new(user: passenger, driver_ride: driver_ride, ride: ride) }

    let(:good_network){ Network.create!(name: "good_network_area") }
    let(:bad_network){ Network.create!(name: "bad_network_area") }

    let(:driver){ User.create!(network: good_network, email: "david@email.com") }
    let(:ride) { Ride.create!(network: good_network, departure: "ici", arrival: "la") }
    let(:driver_ride) { DriverRide.create!(user: driver, ride: ride) }

    describe "When on the same network" do
      let(:passenger){User.create!(network: good_network, email: "peter@email.com")}

      it "create the passenger_ride" do
        expect(subject).to be_valid
        expect(subject.save).to be(true)
      end
    end

    describe "When on a different network" do
      let(:passenger){User.create!(network: bad_network, email: "peter@email.com")}

      it "fail validations" do
        expect(subject).to_not be_valid
        expect(subject.errors[:network]).to eq(["must be on the same network"])
      end
    end
  end
end
