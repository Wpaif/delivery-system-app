class UsersBackoffice::PriceSettingsController < UsersBackofficeController
  def index
    @price_settings = PriceSetting.where(carrier_id: current_user.carrier_id)
  end

  def new
    @price_setting = PriceSetting.new
  end

  def create
    @price_setting = PriceSetting.new(price_setting_params)
    @price_setting.carrier_id = current_user.carrier_id
    if @price_setting.save
      redirect_to users_backoffice_price_settings_path,
                  notice: 'Configuração de preço cadastrada com sucesso.'
    else
      flash[:notice] = 'Não foi possível cadastrar a configuração de preço'
      render :new
    end
  end

  private

  def price_setting_params
    params.require(:price_setting).permit(:lower_limit, :upper_limit, :value, :carrier_id)
  end
end
