class AdminsBackoffice::CarriesController < AdminsBackofficeController
  def index
    @carries = Carrier.where(enable: true)
  end
end