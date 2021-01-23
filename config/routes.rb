Rails.application.routes.draw do
  root "short_urls#new"

  resources :short_urls, only: [:index, :show, :new, :create] do
    member do
      put :disabled
      put :enabled
      put :update
    end
  end
end
