RACK_ENV ||= ENV["RACK_ENV"] ||= "development" unless defined?(RACK_ENV)

require "rubygems" unless defined?(Gem)
require "bundler/setup"
Bundler.require(:default, RACK_ENV)

require "logger"

require "./lib/logging.rb"
require "./lib/scss_init.rb"
require "./lib/config.rb"
require "./lib/site.rb"

module Creepermon
  class Website < Sinatra::Base
    register ScssInitializer
    use Rack::Deflater
    register Sinatra::ActiveRecordExtension

    layout :main

    configure do
      enable :caching
      set :logging, true
      set :protection, true
      set :protect_from_csrf, true
    end

    get "/" do
      erb :index
    end
  end
end
