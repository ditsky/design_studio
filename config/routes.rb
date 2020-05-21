Rails.application.routes.draw do

  #Cards controller
  #get "/cards/:card" => "cards#show"


  get 'birthday', to: 'cards#birthday'
  get 'anniversary', to: 'cards#anniversary'
  get 'sympathy', to: 'cards#sympathy'
  #root 'cards#home'

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
