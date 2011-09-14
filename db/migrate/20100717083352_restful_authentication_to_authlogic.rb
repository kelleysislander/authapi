class RestfulAuthenticationToAuthlogic < ActiveRecord::Migration
  def self.up
    rename_column :users, :salt, :password_salt
    rename_column :users, :remember_token, :persistence_token

    remove_column :users, :remember_token_expires_at
    remove_column :users, :name

    add_column :users, :single_access_token, :string
    add_column :users, :perishable_token, :string
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
