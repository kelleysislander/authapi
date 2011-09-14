class AccountsUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :user

  attr_accessible :account_id, :user_id, :admin
end
