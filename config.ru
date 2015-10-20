require 'rubygems'
require 'rack/jekyll'
require 'yaml'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['frank', 'black']
end

run Rack::Jekyll.new
