class UsersBackoffice::OrdersController < UsersBackofficeController
  before_action :set_order, only: %i[show edit update]

  def index
    @orders = Order.where(carrier_id: current_user.carrier.id)
  end

  def show
    @value = PriceSetting.settings_with_range(params).first.value * @order.weight
    @vehicles = Vehicle.vehicle_available_to_weight(@order.weight).reject(&:order).any?
    cookies[:current_order_id] = params[:id]
  end

  def edit
    @vehicles = Vehicle.vehicle_available_to_weight(@order.weight).reject(&:order)
  end

  def update
    @order.on_carriage!
    if @order.update(order_params)
      redirect_to users_backoffice_order_path(@order), notice: 'Ordem de serviço aceita com sucesso'
    else
      @vehicles = Vehicle.vehicle_available_to_weight(@order.weight)
                         .reject(&:order)
      flash[:notice] = 'Não foi possível aceitar a ordem de serviço'
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:vehicle_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
