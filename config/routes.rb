Rails.application.routes.draw do

  resources :users

  
  get 'pages/contact'
  get 'contact', to: 'pages#contact'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
