Rails.application.routes.draw do
  get 'microposts/index/:id' => 'microposts#index', as: 'microposts_index'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root   'sessions#new'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts do
    resources :comments, only: [:create, :destroy]
    get       :search, on: :collection
    post      'add' => 'likes#create'
    delete    '/add' => 'likes#destroy'
  end

  resources :microposts,          only: [ :new, :create, :destroy, :show]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :notifications,       only: [:index, :destroy]


end
