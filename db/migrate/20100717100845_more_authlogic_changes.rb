class MoreAuthlogicChanges < ActiveRecord::Migration
  def self.up
    change_column :users, :crypted_password, :string, :limit => 128,
      :null => false, :default => ""
    change_column :users, :password_salt, :string, :limit => 128,
      :null => false, :default => ""
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
