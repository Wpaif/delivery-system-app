class AdminsBackoffice::CarriersController < AdminsBackofficeController
  def index
    @carries = Carrier.where(enable: true)
  end

  def show
    @carrier = Carrier.find(params[:id])
  end
end