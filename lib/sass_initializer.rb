module SassInitializer
  def self.registered(app)
    # Enables support for SASS template reloading in rack applications.
    # See http://nex-3.com/posts/88-sass-supports-rack for more details.
    # http://sass-lang.com/documentation/file.SASS_REFERENCE.html#options
    require 'sass/plugin/rack'
    Sass::Plugin.options[:template_location] = Padrino.root("app/css")
    Sass::Plugin.options[:css_location] = Padrino.root("public/css")
    Sass::Plugin.options[:cache] = true
    Sass::Plugin.options[:always_update] = true if app.development?
    Sass::Plugin.options[:style] = :compressed

    app.use Sass::Plugin::Rack
  end
end
