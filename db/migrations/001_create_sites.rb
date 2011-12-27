Sequel.migration do
  change do
    create_table :sites do
      primary_key :id
      String :user
      String :project
      String :url
      DateTime :last_check
      DateTime :create_date
      DateTime :modify_date
    end
  end
end
