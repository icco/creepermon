##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
Padrino.configure_apps do
  set :session_secret, ENV['SESSION_SECRET'] || '9asdjj66cd4e4930a777d61807eb97d44f3d81b346b11175689b5cc'
  set :protection, :except => :path_traversal
  set :protect_from_csrf, true

  if not ENV['SESSION_SECRET']
    logger.warn "SESSION SECRET IS NOT SECURE."
  end
end

# Mounts the core application for this project
Padrino.mount('CreeperMon::App', :app_file => Padrino.root('app/app.rb')).to('/')
