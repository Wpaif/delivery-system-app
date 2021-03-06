# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  resources :order_details, only: [] do
    get '/search', to: 'home#search', on: :collection
  end

  namespace :users_backoffice do
    resources :order_details, only: %i[index new create]
    resources :orders, only: %i[index show edit update]
    resources :deadlines, only: %i[index new create]
    resources :price_settings, only: %i[index new create]
    resources :vehicles, only: %i[index show new create]
    get 'welcome/index'
  end
  get '/user' => 'users_backoffice/welcome#index', :as => :user_root
  devise_for :users

  namespace :admins_backoffice do
    resources :query_history, only: %i[index]
    resources :orders, only: %i[show new create]
    resources :carriers, only: %i[index show new create] do
      post 'disable', on: :member
    end
    get 'welcome/index'
    get 'budgets', to: 'welcome#budgets'
    get 'budget_result', to: 'welcome#budget_result'
  end
  get '/admin', to: 'admins_backoffice/welcome#index', as: 'admin'
  devise_for :admins

  root to: 'home#index'
end
# rubocop:enable Metrics/BlockLength
