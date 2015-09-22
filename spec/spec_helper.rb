$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'rspec'
require 'pry'

RSpec.configure do |config|

  config.color = true

end
