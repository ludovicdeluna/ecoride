class CreatePassengerRides < ActiveRecord::Migration[5.2]
  def change
    create_table :passenger_rides do |t|
      t.references :user, foreign_key: true
      t.references :ride, foreign_key: true
      t.references :driver_ride, foreign_key: true

      t.timestamps
    end
  end
end
