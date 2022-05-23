class Deadline < ApplicationRecord
  belongs_to :carrier

  validates :lower_limit, :upper_limit, :days, presence: true

  def range
    Range.new(lower_limit, upper_limit)
  end
end
