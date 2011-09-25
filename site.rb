#!/usr/bin/env ruby
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
   erb :index, :locals => {}
end

post '/' do
   redirect '/'
end

post '/commit' do
  p params
end


## Oauth Stuff for GitHub
get '/login' do
  client = GITHUB_CLIENT_ID
  redirect "https://github.com/login/oauth/authorize?client_id=#{client}"
end

get '/authed' do
  GitHub.access_token(params["code"]).inspect
end

## Style sheet
get '/style.css' do
   content_type 'text/css', :charset => 'utf-8'
   less :style
end

class Entry < Sequel::Model(:entries)
end

class GitHub
  include HTTParty
  base_uri 'https://github.com'

  def GitHub.access_token(code)
    options = {
      :client_id => GITHUB_CLIENT_ID,
      :client_secret => GITHUB_CLIENT_SECRET,
      :code => code
    }

    GitHub.post('/login/oauth/access_token', options)
  end
end
