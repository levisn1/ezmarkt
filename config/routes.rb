Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resource :products
  resource :order
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
