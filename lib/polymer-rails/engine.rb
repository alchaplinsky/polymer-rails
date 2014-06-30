module Polymer
  module Rails
    class Engine < ::Rails::Engine
      config.assets.precompile += %w( polymer/polymer.js )
    end
  end
end
