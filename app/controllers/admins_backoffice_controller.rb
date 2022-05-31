class AdminsBackofficeController < ApplicationController
  before_action :authenticate_admin!
end
