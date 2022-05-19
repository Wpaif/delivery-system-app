class Carrier < ApplicationRecord
  validates :brand_name, :corporate_name, :email_domain,
            :registered_number, :billing_address, presence: true
  validates :registered_number, format: { with: %r{\A\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}\z} }
end
