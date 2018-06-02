Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  patch 'mylocation', to: 'users#update_mylocation'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :books, only: [:new, :create, :edit, :update]
  get 'search', to: 'books#search'
  resources :profiles, only: [:show, :new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
end