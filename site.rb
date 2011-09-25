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
  client = '27affb525ae9efd596a0'
  redirect "https://github.com/login/oauth/authorize?client_id=#{client}"
end

get '/authed' do
  p params
end


## Style sheet
get '/style.css' do
   content_type 'text/css', :charset => 'utf-8'
   less :style
end

class Entry < Sequel::Model(:entries)
end
