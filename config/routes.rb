Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get 'movies/index'

  root 'movies#index'
  resources :movies, only: [:create,:show,:update,:destroy,:index]


  post 'user_token' => 'user_token#create'

  get '/users'      => 'users#index'
  post '/users/create'  => 'users#create'

  post "login", to: "authentication#login"

  resources :movies

  get 'characters/index'
  resources :characters, only: [:create,:show,:update,:destroy,:index]


end
