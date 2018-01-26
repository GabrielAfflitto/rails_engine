Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/invoices', to: 'invoices#show'
        get ':id/items', to: 'items#show'
        get ':id/revenue', to: 'revenue#show'
        get 'revenue', to: 'revenue_date#index'
        get 'most_revenue', to: 'revenue#index'
        get 'most_items', to: 'most_items#index'
        get ':id/favorite_customer', to: 'favorite_customer#show'
      end

      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/invoices', to: 'invoices#show'
        get ':id/transactions', to: 'transactions#show'
        get ':id/favorite_merchant', to: 'favorite_merchant#show'
      end

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/invoice', to: 'invoice#show'
      end

      namespace :invoices do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/transactions', to: 'transactions#show'
        get ':id/invoice_items', to: 'invoice_items#show'
        get ':id/items', to: 'items#show'
        get ':id/customer', to: 'customer#show'
        get ':id/merchant', to: 'merchant#show'

      end

      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get 'most_revenue', to: 'most_revenue#index'
        get 'most_items', to: 'most_items#index'
        get ':id/invoice_items', to: 'invoice_items#show'
        get ':id/merchant', to: 'merchant#show'
      end

      namespace :invoice_items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/invoice', to: 'invoice#show'
        get ':id/item', to: 'item#show'

      end

      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
