Rails.application.routes.draw do
  root to: "home#index"
  resources :home, only: [:show]
  devise_for :users
  resources :messages, only: [:index, :create]
  namespace :owner do
    resources :buffets, only: [:new, :create, :show, :edit, :update] do
      resources :events, only: [:new, :create, :show, :edit, :update]
    end
    resources :event_prices, only: [:new, :create, :edit, :update]
    resources :orders, only: [:index, :show, :edit, :update]
    resources :dashboards, only: [:index]
  end

  namespace :client do
    resources :buffets do
      get 'search', on: :collection
    end
    resources :orders, only: [:new, :create, :show, :update]
    resources :dashboards, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      resources :buffets, only: [:index, :show] do
        get 'search/:query', on: :collection, to: "buffets#search"
        get 'events', on: :member, to: "buffets#events"
        get ':event_id/:event_date/:total_guests', to: "buffets#check_availability"
      end
    end
  end
end
