Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :products
  resources :orders, only: [:show, :create, :index, :destroy, :update]
  post '/payment', action: :payorder, controller: 'orders'
  patch '/orders', action: :update, controller: 'orders'

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
