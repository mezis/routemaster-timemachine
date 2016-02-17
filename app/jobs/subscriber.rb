require 'routemaster/client'

class Subscriber < ActiveJob::Base
  queue_as :default

  ALLOWED_TOPICS = [
    'photos',
    'unavailabilities',
    'properties',
    'rates',
    'users_api_tokens',
    'properties_external',
    'users_photo'
  ]

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
