class AdminsBackoffice::WelcomeController < AdminsBackofficeController
  def index; end

  def budgets
    @carriers = Carrier.where(enable: true).select do |carrier|
      carrier.deadlines.any? && carrier.price_settings.any?
    end
  end

  def budget_result
    if params[:weigth].empty? || params[:distance].empty?
      @error = true
    else
      set_variables
    end
  end

  private

  def set_variables
    @price_setting = PriceSetting.get_setting_by_id(params)
                                 .settings_with_range(params)
    @weigth = params[:weigth].to_i
    @deadline = Deadline.get_deadline_by_id(params)
                        .deadlines_with_range(params)
    add_searh_in_hitory
  end

  def add_searh_in_hitory
    if @deadline.methods.include?(:days) && @price_setting.methods.include?(:value)
      SearchHistory.create(value: @price_setting.value * params[:weigth].to_i,
                           estimated_delivery_date: @deadline.days.day.from_now,
                           admin_id: current_admin.id)
    end
  end
end
