# An app for ...
# @author Nat Welch - https://github.com/icco

begin
  require "rubygems"
rescue LoadError
  puts "Please install Ruby Gems to continue."
  exit
end

configure do
  set :sessions, true
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://data.db')
  GITHUB_CLIENT_ID = '27affb525ae9efd596a0'
  GITHUB_CLIENT_SECRET = 'ca3ce0901ac2a8f1410e6a98efc8d447ba9efa6f'
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

## Oauth Stuff for GitHub
# Based off of https://gist.github.com/4df21cf628cc3a8f1568 because I'm an idiot...
def client
  OAuth2::Client.new(GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET, {
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
  def Site.getAll username, access_token
    p client
    reponse = client.request(:get, '/user/repos')
    p response
    all_repos = JSON.parse(response.body)
    sites = Site.find(:user => username)

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
