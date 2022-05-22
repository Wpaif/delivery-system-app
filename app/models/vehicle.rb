class Vehicle < ApplicationRecord
  belongs_to :carrier
  validates :plate, :brand, :model, :manufacturing_year, :capacity, presence: true
  validates :plate, format: { with: /\A[A-Z]{3}[0-9]{4}\z/ }
  validates :plate, uniqueness: { case_sensitive: false }
  validates :manufacturing_year, comparison: { less_than_or_equal_to: Date.today.year }
end
