class DropOldTables < ActiveRecord::Migration
  def self.up
    drop_table :sites
    drop_table :runs
  end

  def self.down
    create_table "runs", :force => true do |t|
      t.string   "url"
      t.boolean  "success"
      t.text     "output"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "sites", :force => true do |t|
      t.string   "url"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end
end
