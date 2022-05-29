class Order < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :carrier

  validates :status, :recipient, :distance, :postal_code, :city,
            :street, :number, :weight, :code, :carrier_id,
            presence: true

  validates :code, format: { with: /\A[0-9A-Z]{15}\z/ }
  validates :postal_code, format: { with: /\A[0-9]{5}-?[0-9]{3}\z/ }

  before_validation :generate_code

  enum status: { pending: 0, on_carriage: 1, delivered: 2 }

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
