Rails.application.routes.draw do
  get("/", { :controller => "places", :action => "index" })
  resources :entries
  resources :places
  resources :sessions
  resources :users

  # Login/logout
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  # Define the root route
  root 'places#index'
end
