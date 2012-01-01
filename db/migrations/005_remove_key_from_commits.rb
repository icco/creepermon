Sequel.migration do
  change do
    alter_table :commits do
      drop_constraint(:id, :type => :primary_key)
      add_index :id
    end
  end
end
