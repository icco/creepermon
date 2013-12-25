module CreeperMon
  class App < Padrino::Application
    set :root, File.dirname(__FILE__)
    register Sinatra::AssetPack
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    ##
    # Asset Compilation
    #
    assets {
      serve '/js',     from: 'js'        # Default
      serve '/css',    from: 'css'       # Default
      serve '/img',    from: 'img'    # Default

      # The second parameter defines where the compressed version will be served.
      # (Note: that parameter is optional, AssetPack will figure it out.)
      js :app, '/js/app.js', [
        '/js/vendor/**/*.js',
        '/js/lib/**/*.js'
      ]

      css :app, '/css/app.css', [
        '/css/*.css',
        '/css/*.scss',
      ]

      js_compression  :uglify
      css_compression :sass
    }

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
