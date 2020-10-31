Rails.application.routes.draw do
  root "home#index"

  get :login, to: "sessions#new", as: :login
  post :login, to: "sessions#create"
  get :register, to: "users#new", as: :register
  post :register, to: "users#create"

  resources :users, only: %i(new create) do
    resources :csv, only: %i(index new create show)
  end
end
