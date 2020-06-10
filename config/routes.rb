Rails.application.routes.draw do

  #Password Resets Routes
  get 'password_resets/new'
  get 'password_resets/edit'

  #Sessions controller
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#logout'

  #Pages controller
  get 'contact', to: 'pages#contact'
  root 'pages#home'


  #Resources:
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :cards
  resources :shopping_carts, only: [:show]
  resources :selections, only: [:create, :destroy] do
    collection do 
      delete 'remove_card'
    end
  end
  resources :orders, only: [:index, :show, :new, :create, :destroy]

end
