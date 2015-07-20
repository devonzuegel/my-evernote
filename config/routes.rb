Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/connect'                 => 'evernote_login#onboarding', as: :onboarding
  get '/auth/:provider/callback' => 'evernote_login#callback'
  get '/logout'                  => 'evernote_login#logout', as: :logout
  get '/oauth_failure'           => 'evernote_login#oauth_failure'
end
