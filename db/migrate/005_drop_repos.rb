class DropRepos < ActiveRecord::Migration
  def self.up
    drop_table :repos
  end

  def self.down
    create_table :repos do |t|
      t.string :user
      t.string :repo
      t.boolean :status
      t.timestamps
    end
  end
end
