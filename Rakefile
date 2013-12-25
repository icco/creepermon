require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'padrino-pipeline/tasks'

PadrinoTasks.use(:database)
PadrinoTasks.use(:activerecord)
PadrinoTasks.init

desc "Run a local server."
task :local do
  Kernel.exec("shotgun -s thin -p 9393")
end

desc "Compile and add assets"
task :build_assets do
  Rake::Task["pipeline:clean"].invoke
  Kernel.system("git rm public/{js,css}/application*")
  Kernel.system("git commit -m 'Clean assets'")
  Rake::Task["pipeline:compile"].invoke
  Kernel.system("git add --all public/{js,css}/application*")
  Kernel.system("git commit -m 'Compile assets'")
end
