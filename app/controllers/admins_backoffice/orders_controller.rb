class AdminsBackoffice::OrdersController < AdminsBackofficeController
  def show
    # Deve ser visto por ambos os usuários (Por enquando está só para admin)
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @carriers = Carrier.where(enable: true)
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to admins_backoffice_order_path(@order), notice: 'A ordem de serviço foi criada'
    else
      @carriers = Carrier.where(enable: true)
      flash.now[:notice] = 'A ordem de serviço não pode ser criada'
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:recipient, :postal_code, :city, :street, :number,
                                  :weight, :distance, :carrier_id)
  end
end
