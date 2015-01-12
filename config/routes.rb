Rails.application.routes.draw do

  resources :events, only: [:index, :show] do
    member do
      get 'replay'
    end
  end

  mount $drainer => '/events'

  root 'events#index'

  require 'sidekiq/web'
  require 'sidetiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
