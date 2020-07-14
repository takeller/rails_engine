Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants/search#show'
      get 'merchants/most_revenue', to: 'merchants/revenue#index'
      resources :items do
        get 'merchant', to: 'merchants#show'
      end
      resources :merchants do
        resources :items, only: [:index]
      end
    end
  end
end
