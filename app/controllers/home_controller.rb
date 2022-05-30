class HomeController < ApplicationController
  def index; end

  def search
    @order = Order.where(code: params[:code])
    if @order.any?
      @order = @order.first
    else
      redirect_to root_path, notice: 'Código inválido'
    end
  end
end