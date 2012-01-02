Sequel.migration do
  change do
    alter_table :sites do
      drop_column :last_check
    end
  end
end
