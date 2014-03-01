class RemoveUserTable < ActiveRecord::Migration
  def self.up
    drop_table :users
  end

  def self.down
    create_table :users do |t|
      t.string :name, null: false
      t.string :crypted_password, null: false
      t.string :email
      t.string :repo
      t.timestamps
    end
  end
end
