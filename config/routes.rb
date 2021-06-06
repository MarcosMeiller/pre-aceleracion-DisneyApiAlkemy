Rails.application.routes.draw do
  get 'movies/index'

  root 'movies#index'
  get 'movies/search', to: 'movies#search'

  resources :movies, only: [:create,:show,:update,:destroy,:index]

  post 'user_token' => 'user_token#create'

  get '/users'      => 'users#index'
  post '/users/create'  => 'users#create'

  post "login", to: "authentication#login"

  resources :movies

  get 'characters/index'
  get 'characters/search', to:'characters#search'
  resources :characters, only: [:create,:show,:update,:destroy,:index]
  get 'genres/index'
  resources :genres, only: [:create,:show,:update,:destroy,:index]

end
