class AssociateWebAppsAndAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts_web_apps, :id => false do |t|
      t.integer :account_id
      t.integer :web_app_id
    end
  end

  def self.down
    drop_table :accounts_web_apps
  end
end
