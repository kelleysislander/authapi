class CreateAuthenticationCodes < ActiveRecord::Migration
  def self.up
    create_table :authentication_codes do |t|
      t.integer :account_id
      t.string :hash_code
      t.timestamps
    end
  end
  
  def self.down
    drop_table :authentication_codes
  end
end
