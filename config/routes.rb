Rails.application.routes.draw do
  get 'relationshipmessages/create'

  root to: 'toppages#index'

  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create] 
  patch 'mylocation', to: 'users#update_mylocation'
  # patch 'mymessage', to: 'users#update_message_user_id'
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
end