Sequel.migration do
  change do
    alter_table :commits do
      add_index :sha
    end
  end
end
