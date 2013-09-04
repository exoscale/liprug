$stdout.sync = true
$:.unshift File.dirname(__FILE__) + '/lib'

require 'liprug/service'

run Rack::URLMap.new('/' => Liprug::Service)