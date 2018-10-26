Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :products
  resources :orders do
    collection do
      post '/payment', action: :payorder, controller: 'orders'
      patch '/update', action: :update, controller: 'orders'
      get '/previousorders', action: :previous_orders, controller: 'orders'
    end
  end
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
