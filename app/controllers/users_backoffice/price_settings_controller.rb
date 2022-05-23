class UsersBackoffice::PriceSettingsController < UsersBackofficeController
  def index
    @price_settings = PriceSetting.where(carrier_id: current_user.carrier_id)
  end
end