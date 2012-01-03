# An app for creeping on GitHub.
# @author Nat Welch - https://github.com/icco

begin
  require "rubygems"
rescue LoadError
  puts "Please install Ruby Gems to continue."
  exit
end

configure do
  # for enabling nice errors until we launch
  set :show_exceptions, true

  # Enables cookies and sessions
  set :sessions, true

  # Database connection
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/data.db')

  # Github OAuth keys.
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

get '/commits' do
  if session["user"] and session["token"]
    access_token = session["token"]
    access_token = OAuth2::AccessToken.new(client, access_token)
    response = access_token.get("/users/#{session["user"]}/events?per_page=100")
    all_events = JSON.parse(response.body)

    # "Log" the headers.
    p response.headers

    filtered = all_events.delete_if { |event| event["type"] != "PushEvent" }

    filtered.each do |event|
      user, repo = event["repo"]["name"].split("/")
      event["payload"]["commits"].each do |commit|
        cm = Commit.create(user, repo, commit["sha"], Time.parse(event["created_at"]))
      end
    end

    erb :commits, :locals => { :commits => Commit.all }
  else
    redirect '/login'
  end
end

# http://developer.github.com/v3/repos/commits
get '/commits/more' do
  if session["user"] and session["token"]
    sites = Site.getAll(session["user"], session["token"])

    access_token = session["token"]
    access_token = OAuth2::AccessToken.new(client, access_token)

    sites.each do |site|
      puts "Querying: /repos/#{site.user}/#{site.project}/commits?per_page=100"
      response = access_token.get("/repos/#{site.user}/#{site.project}/commits?per_page=100")
      commits = JSON.parse(response.body)

      # "Log" the headers.
      p response.headers

      commits.each do |commit|
        time = nil
        time = Time.parse(commit["committer"]["date"]) if !commit["committer"]["date"].nil?

        cm = Commit.create(
          site.user,
          site.project,
          commit["sha"],
          time
        )
      end
    end
    erb :commits, :locals => { :commits => Commit.all }
  else
    redirect '/login'
  end
end

## Oauth Stuff for GitHub
# Based off of https://gist.github.com/4df21cf628cc3a8f1568 because I'm an idiot...
def client
  if GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET
    OAuth2::Client.new(GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET, {
      :raise_errors => false,
      :site => 'https://api.github.com',
      :authorize_url => 'https://github.com/login/oauth/authorize',
      :token_url => 'https://github.com/login/oauth/access_token'
    })
  else
    puts "ERROR: CLIENT ID and SECRET not defined"

    return nil
  end
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
    response = access_token.get('/user/repos?per_page=100')
    all_repos = JSON.parse(response.body)
    sites = []

    all_repos.each do |repo|

      # TODO: sites = Site.filter(:user => username).all.to_a
      site = Site.find(:project => repo["name"], :user => username)

      if site.nil?
        site = Site.new
      end

      site.project = repo["name"]
      site.user = username
      site.url = repo["homepage"]
      site.save

      sites.push(site)
    end

    # sort by project name.
    sites = sites.sort {|a,b| a.project <=> b.project }

    return sites
  end

  def before_create
    self.create_date = Time.now
  end

  def before_update
    if self.create_date.nil?
      self.create_date = Time.now
    end

    self.modify_date = Time.now
  end
end

class Commit < Sequel::Model(:commits)
  def self.getAll username, access_token
    access_token = OAuth2::AccessToken.new(client, access_token)
    response = access_token.get("/users/#{username}/events")
    all_events = JSON.parse(response.body)

    return all_events
  end

  def self.create user, repo, sha, date
    cm = Commit.find(
      :project => repo,
      :user => user,
      :sha => sha
    )
    cm = Commit.new if cm.nil?

    cm.sha = sha
    cm.user = user
    cm.project = repo
    cm.create_date = date
    cm.save

    return cm
  end
end
