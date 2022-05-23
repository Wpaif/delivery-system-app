class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.integer :lower_limit
      t.integer :upper_limit
      t.integer :days
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
