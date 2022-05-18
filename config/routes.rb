Rails.application.routes.draw do
  namespace :admins_backoffice do
    resources :carriers, only: %i[index show]
    get 'welcome/index'
  end
  get '/admin', to: 'admins_backoffice/welcome#index', as: 'admin'

  devise_for :admins

  root to: 'home#index'
end
