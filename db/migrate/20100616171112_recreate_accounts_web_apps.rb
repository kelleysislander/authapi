class RecreateAccountsWebApps < ActiveRecord::Migration
  def self.up
    drop_table :accounts_web_apps
    create_table :accounts_web_apps do |t|
      t.integer :account_id
      t.integer :web_app_id
      t.date    :expires_on
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
