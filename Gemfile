source "https://rubygems.org"

ruby "2.4.2"

# Stuff we always need
gem "activerecord", :require => "active_record"
gem "chronic"
gem "erubis", "~> 2.7.0"
gem "json"
gem "keen"
gem "nokogiri"
gem "oj"
gem "pg"
gem "psych"
gem "rack-protection", ">= 2.0.0", :require => "rack/protection"
gem "rake"
gem "rdiscount"
gem "sass"
gem "sinatra", ">= 2.0.0"
gem "sinatra-activerecord", ">= 2.0.13", :require => "sinatra/activerecord"
gem "thin", ">= 1.7.2"
gem "typhoeus"

group :test do
  gem "minitest", :require => "minitest/autorun"
  gem "rack-test", ">= 0.7.0", :require => "rack/test"
  gem "rr"
end

group :development do
  gem "heroku"
  gem "shotgun", ">= 0.9.2"
end
