module Creeper
  class App < Padrino::Application
    register SassInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    OmniAuth.config.logger = logger
    use OmniAuth::Builder do
      provider :developer, :fields => [:nickname] if PADRINO_ENV == "development"
      provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], scope: "user,repo"
    end
  end
end
