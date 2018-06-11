Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create] 
  patch 'mylocation', to: 'users#update_mylocation'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :books, only: [:show, :new, :create, :edit, :update]
  resources :profiles, only: [:show, :new, :create, :edit, :update]
  resources :searches, only: [:index] do
    member do
      get :request_users
      get :requested_users
      get :matched_users
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :relationshipmessages, only: [:create, :destroy]
  resources :messages, only: [:index, :create]
  patch 'accept_trade1', to: 'trade1s#accept_trade1'
  patch 'cancel_trade1', to: 'trade1s#cancel_trade1'
  patch 'finish_trade2', to: 'trade2s#finish_trade2'
  patch 'cancel_trade2', to: 'trade2s#cancel_trade2'
end