Rails.application.routes.draw do
  get '/auth/:provider/callback' => 'login#callback'
  get '/logout'                  => 'login#logout', as: 'logout'
  get '/oauth_failure'           => 'login#oauth_failure'

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
