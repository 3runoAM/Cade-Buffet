Rails.application.routes.draw do
  root to: "home#index"
  resources :buffets, only: [:new, :create, :show, :edit, :update]
  devise_for :users
end
