Rails.application.routes.draw do

  resources :events, only: [:index, :show] do
    member do
      get 'replay', action: :replay_event
    end

    collection do
      get 'replay', action: :replay_events
    end
  end

  mount $drainer => '/events'

  root 'events#index'

  require 'sidekiq/web'
  require 'sidetiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
