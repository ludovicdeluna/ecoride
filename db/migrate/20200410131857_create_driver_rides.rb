class CreateDriverRides < ActiveRecord::Migration[5.2]
  def change
    create_table :driver_rides do |t|
      t.references :user, foreign_key: true
      t.references :ride, foreign_key: true

      t.timestamps
    end
  end
end
