require 'routemaster/client'

class Subscriber
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  ALLOWED_TOPICS = [
    'photos',
    'unavailabilities',
    'properties',
    'rates',
    'users',
    'users_photo'
  ]

  recurrence { hourly.minute_of_hour(0, 15, 30, 45) }

  def perform
    client = Routemaster::Client.new({
      url:  ENV['ROUTEMASTER_URL'],
      uuid: ENV['ROUTEMASTER_CLIENT_UUID']
    })

    client.subscribe({
      topics:   ALLOWED_TOPICS,
      callback: "#{ENV['APP_URL']}#{ENV['ROUTEMASTER_CALLBACK_PATH']}",
      uuid:     ENV['ROUTEMASTER_CALLBACK_UUID'],
      timeout:  ENV['ROUTEMASTER_SUBSCRIBER_TIMEOUT'].to_i,
      max:      5000
    })
  end
end
