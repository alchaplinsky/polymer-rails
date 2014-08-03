$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'rspec'

RSpec.configure do |config|

  config.color = true

end
