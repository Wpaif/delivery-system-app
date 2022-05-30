class OrderDetail < ApplicationRecord
  belongs_to :order
  before_create :set_attributes

  validates :city, presence: true
  validates :city, uniqueness: true

  def set_attributes
    self.date = Date.today
    order.update(status: :delivered) if order.city == city
  end
end
