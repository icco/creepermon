module CreeperMon
  class App < Padrino::Application
    register SassInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    ##
    # Caching support.
    #
    register Padrino::Cache
    enable :caching
    set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', 'cache'))

    ##
    # Application configuration options.
    #
    set :logging, true
    set :js_asset_folder, 'js'
    set :css_asset_folder, 'css'

    ##
    # You can configure for a specified environment like:
    #
    configure :development do
    end

    error 404 do
      render 'errors/404'
    end

    error 505 do
      render 'errors/505'
    end
  end
end
