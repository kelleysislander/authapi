class AccountsWebApp < ActiveRecord::Base
  belongs_to :account
  belongs_to :web_app
  validates_presence_of :expires_on

  attr_accessible :account_id, :web_app_id, :expires_on
end
