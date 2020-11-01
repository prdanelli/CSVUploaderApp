Rails.application.routes.draw do
  root "home#index"

  get :login, to: "sessions#new", as: :login
  post :login, to: "sessions#create"
  delete :logout, to: "sessions#destroy", as: :logout

  get :register, to: "users#new", as: :register
  post :register, to: "users#create"

  resources :users, only: %i(new create)
  resources :user_csvs, only: %i(index new create show)
end
