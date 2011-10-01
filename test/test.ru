$:.push File.expand_path("../lib", __FILE__)
$:.push File.expand_path("../test", __FILE__)
require 'rack/firelogger'
require 'test_app'

use Rack::Reloader, 0
use Rack::Firelogger

map '/' do
  run FireLoggerTestApp
end
