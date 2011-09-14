class AddExpiresOnToAccountsWebApps < ActiveRecord::Migration
  def self.up
    add_column :accounts_web_apps, :expires_on, :date
  end

  def self.down
    remove_column :accounts_web_apps, :expires_on
  end
end
