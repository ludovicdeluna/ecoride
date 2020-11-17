class AddNetworkToRides < ActiveRecord::Migration[5.2]
  def change
    add_reference :rides, :network, null: false, foreign_key: true
  end
end
