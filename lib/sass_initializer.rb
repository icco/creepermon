module SassInitializer
  def self.registered(app)
    # Enables support for SASS template reloading in rack applications.
    # See http://nex-3.com/posts/88-sass-supports-rack for more details.
    # Store SASS files (by default) within 'app/stylesheets'.
    require 'sass/plugin/rack'
    Sass::Plugin.options.merge(
      :always_update => Padrino.env == :development,
      :css_location => Padrino.root("public/css"),
      :full_exception => Padrino.env != :production,
      :never_update => Padrino.env != :production,
      :style => :compact,
      :template_location => Padrino.root("app/css"),
    )
    app.use Sass::Plugin::Rack
  end
end
