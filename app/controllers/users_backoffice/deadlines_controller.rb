class UsersBackoffice::DeadlinesController < ApplicationController
  def index
    @deadlines = Deadline.where(carrier_id: current_user.carrier_id)
  end

  def new
    @deadline = Deadline.new
  end

  def create
    @deadline = Deadline.new(deadline_params)
    @deadline.carrier_id = current_user.carrier_id

    if @deadline.save
      redirect_to users_backoffice_deadlines_path, notice: 'Prazo cadastrado com sucesso.'
    else
      flash[:notice] = 'Não foi possível cadastrar prazo'
      render :new
    end
  end

  private

  def deadline_params
    params.require(:deadline).permit(:lower_limit, :upper_limit, :days)
  end
end
