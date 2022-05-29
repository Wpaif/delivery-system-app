Rails.application.routes.draw do
  namespace :users_backoffice do
    resources :orders, only: %i[index show edit update]
    resources :deadlines, only: %i[index new create]
    resources :price_settings, only: %i[index new create]
    resources :vehicles, only: %i[index show new create]
    get 'welcome/index'
  end
  get '/user' => 'users_backoffice/welcome#index', :as => :user_root
  devise_for :users

  namespace :admins_backoffice do
    resources :orders, only: %i[show new create]
    resources :carriers, only: %i[index show new create]
    get 'welcome/index'
    get 'budgets', to: 'welcome#budgets'
    get 'budget_result', to: 'welcome#budget_result'
  end
  get '/admin', to: 'admins_backoffice/welcome#index', as: 'admin'
  devise_for :admins

  root to: 'home#index'
end
