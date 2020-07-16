Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'items/find', to: 'items/search#show'
      get 'items/find_all', to: 'items/search#index'
      get 'merchants/find', to: 'merchants/search#show'
      get 'merchants/find_all', to: 'merchants/search#index'
      get 'merchants/most_revenue', to: 'merchants/revenue#index'
      get 'merchants/most_items', to: 'merchants/sales#index'
      get 'revenue', to: 'revenue#show'
      resources :items do
        get 'merchant', to: 'merchants#show'
      end
      resources :merchants do
        get '/revenue', to: 'merchants/revenue#show'
        resources :items, only: [:index]
      end
    end
  end
end
