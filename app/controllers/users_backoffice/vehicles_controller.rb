class UsersBackoffice::VehiclesController < UsersBackofficeController
  def index
    @vehicles = Vehicle.where(carrier_id: current_user.carrier_id)
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end
end