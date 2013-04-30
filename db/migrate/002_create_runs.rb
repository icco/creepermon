class CreateRuns < ActiveRecord::Migration
  def self.up
    create_table :runs do |t|
      t.string :url
      t.boolean :success
      t.text :output
      t.timestamps
    end
  end

  def self.down
    drop_table :runs
  end
end
