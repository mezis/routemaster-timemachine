require 'routemaster/client'

class Subscriber
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly.minute_of_hour(0, 15, 30, 45) }

  def perform
    client = Routemaster::Client.new({
      url:  ENV['ROUTEMASTER_URL'],
      uuid: ENV['ROUTEMASTER_CLIENT_UUID']
    })

    client.subscribe({
      topics:   ['photos', 'users_photo', 'properties', 'availabilities', 'rates', 'unavailabilities'],
      callback: "#{ENV['APP_URL']}#{ENV['ROUTEMASTER_CALLBACK_PATH']}",
      uuid:     ENV['ROUTEMASTER_CLIENT_UUID'],
      timeout:  ENV['ROUTEMASTER_SUBSCRIBER_TIMEOUT'].to_i,
      max:      5000
    })
  end
end
