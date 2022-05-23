class PriceSetting < ApplicationRecord
  belongs_to :carrier

  validates :lower_limit, :upper_limit, :value, presence: true

  def range
    Range.new(lower_limit, upper_limit)
  end
end
