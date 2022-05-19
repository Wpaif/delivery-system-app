class AdminsBackoffice::CarriersController < AdminsBackofficeController
  def index
    @carries = Carrier.where(enable: true)
  end

  def show
    @carrier = Carrier.find(params[:id])
  end

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

  private

  def carrier_params
    params.require('carrier').permit(:brand_name, :corporate_name, :email_domain,
                                     :registered_number, :billing_address)
  end
end
