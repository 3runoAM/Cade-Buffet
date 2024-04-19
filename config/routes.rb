Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  namespace :owner do
    resources :buffets, only: [:new, :create, :show, :edit, :update] do
      resources :events, only: [:new, :create, :show, :edit, :update] do
        resources :event_prices, only: [:new, :create, :edit, :update]
      end
    end
    resources :dashboards, only: [:index]
  end
  namespace :client do

  end
end
