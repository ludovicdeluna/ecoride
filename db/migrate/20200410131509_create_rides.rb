class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.string :departure
      t.string :arrival
      t.boolean :open

      t.timestamps
    end
  end
end
