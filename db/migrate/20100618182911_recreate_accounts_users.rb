class RecreateAccountsUsers < ActiveRecord::Migration
  def self.up
    drop_table :accounts_users
    create_table :accounts_users do |t|
      t.integer :account_id
      t.integer :user_id
      t.boolean :admin,       :default => false
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
