Rails.application.routes.draw do

  #SSL
  get '.well-known/acme-challenge/XHFRj0z1DIwRzhB60X7ztfJk47u0x_LDKZq0aNZxQHk', to: 'ssl#verify', defaults: { format: 'json' }

  resources :addresses
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

  #Stripe Endpoints
  post 'secret', to: 'orders#secret'
  post 'webhook', to: 'orders#webhook'


  #Resources:
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :cards do
    member do
      delete 'delete_image'
    end
  end
  resources :shopping_carts, only: [:show]
  resources :selections, only: [:create, :destroy] do
    collection do 
      delete 'remove_card'
    end
  end
  resources :orders, only: [:index, :show, :new, :destroy, :update]

end
