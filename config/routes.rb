Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :items do
        get 'merchant', to: 'merchants#show'
      end
      resources :merchants do
        resources :items, only: [:index]
      end
      get 'merchants/find', to: 'merchants/search#show'
    end
  end
end
