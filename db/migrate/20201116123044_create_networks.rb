class CreateNetworks < ActiveRecord::Migration[5.2]
  def change
    create_table :networks do |t|
      t.string :name

      t.timestamps
    end
    add_index :networks, :name, unique: true
  end
end
