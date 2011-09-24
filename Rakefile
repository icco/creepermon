# Import in official clean and clobber tasks
require 'rake/clean'
CLEAN.include("data.db")

desc "Create local db."
task :db do
   require "sequel"

   DB = Sequel.connect(ENV['DATABASE_URL'] || "sqlite://data.db")

   DB.create_table! :sites do
      primary_key :id
      Integer :user_id
      String :url
      String :github
      DateTime :last_check
      DateTime :create_date
      DateTime :modify_date
   end 

   # Whoa wait... use github.
   DB.create_table! :users do
      primary_key :id

      DateTime :create_date
      DateTime :modify_date
   end 

   puts "Database built."
end

