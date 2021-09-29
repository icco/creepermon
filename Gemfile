source "https://rubygems.org"

ruby "2.4.2"

# Stuff we always need
gem "activerecord", :require => "active_record"
gem "chronic"
gem "erubis", "~> 2.7.0"
gem "json"
gem "keen"
gem "nokogiri", ">= 1.12.5"
gem "oj"
gem "pg"
gem "psych"
gem "rack-protection", :require => "rack/protection"
gem "rake"
gem "rdiscount"
gem "sass"
gem "sinatra"
gem "sinatra-activerecord", :require => "sinatra/activerecord"
gem "thin"
gem "typhoeus"

group :test do
  gem "minitest", :require => "minitest/autorun"
  gem "rack-test", :require => "rack/test"
  gem "rr"
end

group :development do
  gem "heroku", ">= 3.99.4"
  gem "shotgun"
end
