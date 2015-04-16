Rails.application.routes.draw do
  root 'videos#index'
  
  devise_for :users, controllers: { omniauth_callbacks: :omniauth_callbacks }
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#fail'
  resources :users
  
  resources :videos, only: [:index, :new, :create]
  resources :video_uploads, only: [:new, :create]
end
