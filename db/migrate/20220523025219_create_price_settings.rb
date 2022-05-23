class CreatePriceSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :price_settings do |t|
      t.integer :lower_limit
      t.integer :upper_limit
      t.integer :value
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
