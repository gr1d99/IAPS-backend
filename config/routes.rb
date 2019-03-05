Rails.application.routes.draw do
  resource :users, only: :create
  resource :sessions, only: :create
  resources :openings, only: [:index, :create]
end
