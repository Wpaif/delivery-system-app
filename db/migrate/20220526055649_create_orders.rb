class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0
      t.string :recipient
      t.integer :distance
      t.string :postal_code
      t.string :city
      t.string :street
      t.integer :number
      t.integer :weight
      t.integer :code
      t.references :vehicle, foreign_key: true
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
