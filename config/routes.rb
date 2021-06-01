Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get 'movies/index'

  root 'movies#index'
  resources :movies

  get 'characters/index'
  resources :characters
end
