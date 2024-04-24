Rails.application.routes.draw do
  root to: "home#index"
  resources :home, only: [:show]
  devise_for :users
  namespace :owner do
    resources :buffets, only: [:new, :create, :show, :edit, :update] do
      resources :events, only: [:new, :create, :show, :edit, :update]
    end

    resources :event_prices, only: [:new, :create, :edit, :update]
    resources :dashboards, only: [:index]
  end

  namespace :client do
    resources :buffets do
      get 'search', on: :collection
    end
  end
end
