Rails.application.routes.draw do
  get 'sessions/new'
  namespace :admin do
    resources :users
  end
  
  get '/login', to: 'sessions#new'
  post '/sessions/new', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  root to: 'tasks#index'
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
  end
end
