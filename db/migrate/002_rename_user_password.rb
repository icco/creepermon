class RenameUserPassword < ActiveRecord::Migration
  def change
    rename_column :users, :crypted_password, :password
  end
end
