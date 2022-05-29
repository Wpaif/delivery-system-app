class Deadline < ApplicationRecord
  belongs_to :carrier

  validates :lower_limit, :upper_limit, :days, presence: true

  def range
    Range.new(lower_limit, upper_limit)
  end

  # scopes

  scope :deadlines_with_range, lambda { |params|
    where('lower_limit <= ? AND upper_limit >= ?', params[:distance], params[:distance]).first
  }

  scope :deadline_in_range, lambda { |distance|
    find_by('lower_limit <= ? AND upper_limit >= ?', distance, distance)
  }

  scope :get_deadline_by_id, ->(params) { where(carrier_id: params[:carrier_id]) }
end
