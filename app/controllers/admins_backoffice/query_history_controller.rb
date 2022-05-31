class AdminsBackoffice::QueryHistoryController < AdminsBackofficeController
  def index
    @search_history = SearchHistory.where(admin_id: current_admin.id).order(created_at: :desc)
  end
end