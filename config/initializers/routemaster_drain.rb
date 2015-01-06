require 'routemaster/drain/basic'

$drainer = Routemaster::Drain::Basic.new
$drainer.subscribe(Listener.new, prefix: true)
