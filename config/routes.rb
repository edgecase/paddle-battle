Pong::Application.routes.draw do

  devise_for :admins, :controllers => { :omniauth_callbacks => "admins/sessions" }

  devise_scope :admin do
    match '/admins/auth/google/callback' => 'admins/sessions#callback'
    get '/admins/sign_out' => 'devise/sessions#destroy'
  end

  resources :matches
  resources :players

  match '/distribution' => 'players#distribution', :as => 'distribution'

  scope "/api" do
    match "players" => "players#api_index"
    match "players/:id" => "players#api_show"
    match "rankings" => "players#rankings"
  end

  root to: 'players#rankings'
end
