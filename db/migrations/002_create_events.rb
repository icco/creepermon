Sequel.migration do
  change do
    create_table :commit do
      primary_key :id
      String :user
      String :project
      DateTime :create_date
    end
  end
end
