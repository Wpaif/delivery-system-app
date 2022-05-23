class UsersBackoffice::DeadlinesController < ApplicationController
  def index
    @deadlines = Deadline.where(carrier_id: current_user.carrier_id)
  end
end