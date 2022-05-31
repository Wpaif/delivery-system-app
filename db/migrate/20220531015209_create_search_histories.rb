class CreateSearchHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :search_histories do |t|
      t.integer :value
      t.timestamp :estimated_delivery_date
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
