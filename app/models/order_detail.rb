class OrderDetail < ApplicationRecord
  belongs_to :order
  before_create :set_attributes

  validates :city, presence: true
  validates :city, uniqueness: true

  def set_attributes
    order.update(status: :delivered) if order.city == city
  end
end
