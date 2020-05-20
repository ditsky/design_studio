Rails.application.routes.draw do

  #Sessions controller
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#logout'

  #Pages controller
  get 'contact', to: 'pages#contact'
  root 'pages#home'

  #Resources:
  resources :users
end
