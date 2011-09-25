# Import in official clean and clobber tasks
require 'rake/clean'
CLEAN.include("data.db")

desc "Create local db."
task :db do
   require "sequel"

   DB = Sequel.connect(ENV['DATABASE_URL'] || "sqlite://data.db")

   DB.create_table! :sites do
      primary_key :id
      String :user
      String :project
      String :url
      DateTime :last_check
      DateTime :create_date
      DateTime :modify_date
   end 

   puts "Database built."
end

