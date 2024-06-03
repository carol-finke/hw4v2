Rails.application.routes.draw do
  root 'places#index'
  
  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get("/logout", { :controller => "sessions", :action => "destroy" })

  
  resources :users, only: [:create]
  resources :places do
    resources :entries, only: [:index, :new, :create, :show]
  end
end
