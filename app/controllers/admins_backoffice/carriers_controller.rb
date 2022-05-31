class AdminsBackoffice::CarriersController < AdminsBackofficeController
  before_action :set_carrier, only: %i[show disable]
  def index
    @carries = Carrier.where(enable: true)
  end

  def show; end

  def new
    @carrier = Carrier.new
  end

  def create
    @carrier = Carrier.new(carrier_params)
    @carrier.enable = true
    if @carrier.save
      redirect_to admins_backoffice_carrier_path(@carrier),
                  notice: 'Transportadora registrada com sucesso.'
    else
      flash[:notice] = 'Não foi possível registrar a transportadora.'
      render new_admins_backoffice_carrier_path
    end
  end

  def disable
    @carrier.update(enable: false)
    redirect_to admins_backoffice_carrier_path(@carrier),
                notice: 'Transportadora desativada com sucesso'
  end

  private

  def carrier_params
    params.require('carrier').permit(:brand_name, :corporate_name, :email_domain,
                                     :registered_number, :billing_address)
  end

  def set_carrier
    @carrier = Carrier.find(params[:id])
  end
end
