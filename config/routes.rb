Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get 'movies/index'

  root 'movies#index'
  resources :movies, only: [:index]

  post 'user_token' => 'user_token#create'

  get '/users'      => 'users#index'
  post '/users/create'  => 'users#create'
  resources :movies

  get 'characters/index'
  resources :characters, only: [:index]


end
