Routemaster Timemachine
=======================
[![Build Status](https://travis-ci.org/HouseTrip/routemaster-timemachine.svg?branch=master)](https://travis-ci.org/HouseTrip/routemaster-timemachine)

View, filter, replay and paginate through previous Routemaster events

## How it works

Listens to pre-configured topics with `routemaster-client`. Whenever a new topic event is sent through `routemaster`, this app stores it on postgres.

The web interface allows to search and replay a subset of routemaster events recorded. Replay is done by re-sending the messages (including the original timestamp).

## Setup

Requires:
- Routemaster set up
- Redis
- Postgres
- Tunnels

```
cp .env.example .env
echo 1357 > ~/.pow/routemaster-timemachine
bundle
bundle exec rake db:create db:migrate
bundle exec foreman start
open "https://routemaster-timemachine.dev"
```
