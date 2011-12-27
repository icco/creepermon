# An app for creeping on GitHub.
# @author Nat Welch - https://github.com/icco

begin
  require "rubygems"
rescue LoadError
  puts "Please install Ruby Gems to continue."
  exit
end

configure do
  set :sessions, true
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/data.db')
  GITHUB_CLIENT_ID = ENV['GITHUB_CLIENT_ID']
  GITHUB_CLIENT_SECRET = ENV['GITHUB_CLIENT_SECRET']
end

get '/' do
  if session["user"] and session["token"]
    redirect '/sites'
  else
    erb :index, :locals => {}
  end
end

get '/sites' do
  if session["user"] and session["token"]
    sites = Site.getAll(session["user"], session["token"])
    erb :sites, :locals => { "sites" => sites }
  else
    redirect '/'
  end
end

post '/gitpush' do
  p params
end

get '/events' do
  if session["user"] and session["token"]
    access_token = session["token"]
    access_token = OAuth2::AccessToken.new(client, access_token)
    response = access_token.get("/users/#{session["user"]}/events")
    all_events = JSON.parse(response.body)

    filtered = all_events.delete_if {|key,event| event.type != "PushEvent" }

    %(<pre>#{JSON.generate(filtered)}</pre>)
  else
    redirect '/'
  end
end

## Oauth Stuff for GitHub
# Based off of https://gist.github.com/4df21cf628cc3a8f1568 because I'm an idiot...
def client
  OAuth2::Client.new(GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET, {
    :raise_errors => false,
    :site => 'https://api.github.com',
    :authorize_url => 'https://github.com/login/oauth/authorize',
    :token_url => 'https://github.com/login/oauth/access_token'
  })
end

get '/login' do
  url = client.auth_code.authorize_url()
  puts "Redirecting to URL: #{url.inspect}"
  redirect url
end

get '/authed' do
  begin
    session["code"] = params[:code]
    access_token = client.auth_code.get_token(params[:code])
    user = JSON.parse(access_token.get('/user').body)

    # Pull out the data we care about
    session['user'] = user["login"]
    session['token'] = access_token.token

    #%(<p>Your OAuth access token: #{access_token.token}</p><p>Your extended profile data:\n#{user.inspect}</p>)
    redirect '/sites'
  rescue OAuth2::Error => e
    %(<p>Outdated ?code=#{params[:code]}:</p><p>#{$!}</p><p><a href="/login">Retry</a></p>)
  end
end

## Style sheet
get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  less :style
end

class Site < Sequel::Model(:sites)
  def self.getAll username, access_token
    access_token = OAuth2::AccessToken.new(client, access_token)
    response = access_token.get('/user/repos')
    all_repos = JSON.parse(response.body)
    sites = Site.find(:user => username)
    sites = [] if sites.nil?

    all_repos.each do |repo|
      site = Site.new
      site.project = repo["name"]
      site.user = username
      site.url = repo["homepage"]
      sites.push(site)
    end

    return sites
  end
end

#class Event < Sequel::Model(:events)
#  def self.getAll username, access_token
#    access_token = OAuth2::AccessToken.new(client, access_token)
#    response = access_token.get("/users/#{username}/events")
#    all_events = JSON.parse(response.body)
#
#    return all_events
#  end
#end
