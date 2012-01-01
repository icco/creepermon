Sequel.migration do
  change do
    alter_table :commits do
      set_column_type :id, String 
    end
  end
end
