class AdminsBackoffice::OrdersController < AdminsBackofficeController
  def new
    @order = Order.new
  end
end