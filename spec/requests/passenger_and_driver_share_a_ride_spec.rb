require "rails_helper"

RSpec.describe "Ride sharing between a driver and a passenger", :type => :request do

  let(:network){ Network.create!(name: "network_area") }
  let(:driver){ User.create!(network: network, email: "david@email.com") }
  let(:passenger){User.create!(network: network, email: "peter@email.com")}
  let(:ride){Ride.create!(network: network, departure: "ici", arrival: "la") }
  let(:json_response) { JSON.parse(response.body) }
  let(:network_header) { {"X-CURRENT-NETWORK" => network.id} }

  it "creates a Widget and redirects to the Widget's page" do
    post "/graphql", headers: network_header, params: {
      query: "mutation{
        createDriverRide(
          input: {
          	userId: #{driver.id},
          	rideId: #{ride.id}
        	}
        ){
          driverRide{
            id
          }
          errors
        }
      }"
    }

    expect(response.status).to eq(200)
    expect(json_response.dig("data", "createDriverRide", "errors")).to eq([])

    driver_ride_id = json_response.dig("data", "createDriverRide", "driverRide", "id")
    expect(driver_ride_id).not_to be(nil)

    driver_ride = DriverRide.find(driver_ride_id)
    expect(driver_ride.user).to eq(driver)
    expect(driver_ride.ride).to eq(ride)

    post "/graphql", headers: network_header, params: {
      query: "mutation{
        createPassengerRide(
          input: {
          	userId: #{passenger.id},
          	rideId: #{ride.id}
        	}
        ){
          passengerRide{
            id
          }
          errors
        }
      }"
    }

    expect(PassengerRide.last.user).to eq(passenger)
    expect(PassengerRide.last.ride).to eq(ride)

    post "/graphql", headers: network_header, params: {
      query: "mutation{
        shareRide(
          input: {
          	driverRideId: #{DriverRide.last.id},
          	passengerRideId: #{PassengerRide.last.id}
        	}
        ){
          passengerRide{
            id
          }
          errors
        }
      }"
    }

    expect(PassengerRide.last.driver_ride).to eq(DriverRide.last)

    expect(response.status).to eq(200)
    response_json = JSON.parse(response.body)
    expect(response_json.dig("data", "shareRide", "passengerRide", "id")).to eq(PassengerRide.last.id)
  end
end
