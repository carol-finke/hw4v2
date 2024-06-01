Rails.application.routes.draw do
  # Define the root route
  root 'places#index'

  # Resources for entries, places, users
  resources :entries
  resources :places
  resources :users

  # Custom routes for login/logout
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # This line is redundant since the root route is defined above
  # get("/", { :controller => "places", :action => "index" })
end
