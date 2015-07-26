Rails.application.routes.draw do
  resources :notes, except: %i(new destroy)
  resources :notebooks, except: %i(new destroy)
  root to: 'visitors#index'

  devise_for :users, controllers: {  # Add others if customized.
    sessions: 'registrations/sessions',
    registrations: 'registrations/registrations'
  }
  resources :users

  get '/connect'                 => 'evernote_login#onboarding', as: :onboarding
  get '/auth/:provider/callback' => 'evernote_login#callback'
  get '/logout'                  => 'evernote_login#logout', as: :logout
  get '/oauth_failure'           => 'evernote_login#oauth_failure'
end
