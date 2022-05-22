class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :brand
      t.string :model
      t.integer :manufacturin_year
      t.integer :capacity
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
