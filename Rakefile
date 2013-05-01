require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:activerecord)
PadrinoTasks.init

task :default => :test

desc "Run a local server."
task :local do
  Kernel.exec("shotgun -s thin -p 9393")
end

desc "Pings all of the sites."
task :cron do
  Ping.select(:site).uniq.each do |s|
    Ping.factory s
  end
end
