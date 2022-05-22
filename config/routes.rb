Rails.application.routes.draw do
  namespace :users_backoffice do
    resources :vehicles, only: %i[index]
    get 'welcome/index'
  end
  get '/user' => 'users_backoffice/welcome#index', :as => :user_root
  devise_for :users

  namespace :admins_backoffice do
    resources :carriers, only: %i[index show new create]
    get 'welcome/index'
  end
  get '/admin', to: 'admins_backoffice/welcome#index', as: 'admin'
  devise_for :admins

  root to: 'home#index'
end
