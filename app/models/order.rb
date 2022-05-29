class Order < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :carrier

  before_create :generate_code
  enum status: { pending: 0, on_carriage: 1, delivered: 2 }

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
