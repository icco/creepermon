module CreeperMon
  class App < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    ##
    # Asset Compilation
    #
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::Sprockets
      config.compiled_output = Padrino.root('public')
      config.enable_compression = true

      config.css_prefix = '/css'
      config.css_assets = Padrino.root('app', 'css')
      config.css_compiled_output = 'css'

      config.js_prefix = '/js'
      config.js_assets = Padrino.root('app', 'js')
      config.js_compiled_output = 'js'
    end

    ##
    # Sessions
    #
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
    #set :js_asset_folder, 'js'
    #set :css_asset_folder, 'css'

    ##
    # Auth
    #
    enable :authentication
    set :login_page, "/login"

    ##
    # You can configure for a specified environment like:
    #
    configure :development do
    end
  end
end
