class DropUsersTable < ActiveRecord::Migration
  def self.up
    drop_table :users
  end

  def self.down
    create_table "users", :force => true do |t|
      t.string   "name"
      t.text     "sites"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end
end
