class Order < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :carrier

  enum status: { pending: 0, on_carriage: 1, delivered: 2 }
end
