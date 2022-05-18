class CreateCarriers < ActiveRecord::Migration[7.0]
  def change
    create_table :carriers do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :email_domain
      t.string :registered_number
      t.string :billing_address
      t.boolean :enable

      t.timestamps
    end
  end
end
