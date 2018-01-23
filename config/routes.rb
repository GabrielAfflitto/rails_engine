Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :invoices, only: [:index]
      resources :items, only: [:index]
      resources :invoice_items, only: [:index]
    end
  end

end
