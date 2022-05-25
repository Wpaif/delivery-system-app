class PriceSetting < ApplicationRecord
  belongs_to :carrier

  validates :lower_limit, :upper_limit, :value, presence: true

  def range
    Range.new(lower_limit, upper_limit)
  end

  # scopes
  scope :settings_with_range, lambda { |params|
    where('lower_limit <= ? AND upper_limit >= ?', params[:weigth], params[:weigth]).first
  }

  scope :get_setting_by_id, ->(params) { where(carrier_id: params[:carrier_id]) }
end
