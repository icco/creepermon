require "bundler/setup"
require "./site"

task :default do
  puts "No tests written."
end

desc "Run a local server."
task :local do
  Kernel.exec("shotgun -s thin -p 9393")
end

desc "Scrape your sites."
task :cron do
  config = Creepermon::Config.load_config "./sites.yml"

  config.sites.each do |s|
    data = s.scrape
    data[:url] = s.url
    Keen.publish(:scrape, data)
  end
end
