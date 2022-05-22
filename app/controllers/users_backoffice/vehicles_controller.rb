class UsersBackoffice::VehiclesController < UsersBackofficeController
  def index
    @vehicles = Vehicle.where(carrier_id: current_user.carrier_id)
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.carrier_id = current_user.carrier_id
    if @vehicle.save
      redirect_to users_backoffice_vehicle_path(@vehicle), notice: 'Veículo cadastrado com sucesso.'
    else
      flash.now[:notice] = 'O veículo não pode ser cadrasatado.'
      render :new
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:plate, :brand, :model, :manufacturing_year, :capacity)
  end
end
