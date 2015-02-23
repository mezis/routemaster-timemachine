Rails.application.routes.draw do

  resources :events, only: [:index, :show] do
    member do
      get 'replay', action: :replay_event
    end

    collection do
      get 'replay', action: :replay_events
    end
  end

  get 'health', to: 'monitor#health'

  mount $drainer => '/events'

  root 'events#index'

  require 'sidekiq/web'
  require 'sidetiq/web'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV.fetch('USERNAME') && password == ENV.fetch('PASSWORD')
  end

  mount Sidekiq::Web => '/sidekiq'
end
