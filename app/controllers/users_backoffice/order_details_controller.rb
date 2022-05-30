class UsersBackoffice::OrderDetailsController < UsersBackofficeController
  def new
    @order_detail = OrderDetail.new
  end

  def create
    @order_detail = OrderDetail.new(order_details_params)
    @order_detail.order_id = cookies[:current_order_id]

    if @order_detail.save
      redirect_to users_backoffice_order_path(@order_detail.order_id),
                  notice: 'Status da ordem de serviço atualizado com sucesso'
    else
      flash[:notice] = 'Não foi possível atualizar o status da ordem de serviço'
      render :new
    end
  end

  private

  def order_details_params
    params.require(:order_detail).permit(:city)
  end
end
