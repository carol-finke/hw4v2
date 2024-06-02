Rails.application.routes.draw do
  root 'places#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :places do
    resources :entries, only: [:index, :new, :create, :show]
  end
end
