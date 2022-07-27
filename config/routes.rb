Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  
  root "tasks#index"

  #get 'sessions/new'
  resources :users
  resources :tasks
  resources :users, only: %i[new create show edit]
  resources :sessions, only: %i[new create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
