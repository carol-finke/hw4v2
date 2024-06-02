Rails.application.routes.draw do
  root 'places#index'
  
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :places do
    resources :entries, only: [:new, :create, :index, :show]
  end
end
