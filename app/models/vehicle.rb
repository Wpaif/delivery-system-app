class Vehicle < ApplicationRecord
  belongs_to :carrier
  validates :plate, :brand, :model, :manufacturin_year, :capacity, presence: true
  validates :plate, format: { with: /\A[A-Z]{3}[0-9]{4}\z/ }
  validates :manufacturin_year, comparison: { less_than: Date.today }
end
