Pong::Application.routes.draw do

  match '/auth/google/callback' => 'session#create'

  resources :matches
  resources :players

  match '/distribution' => 'players#distribution', :as => 'distribution'

  root to: 'players#rankings'
end
