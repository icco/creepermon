Sequel.migration do
  change do
    rename_table :commit, :commits
  end
end
