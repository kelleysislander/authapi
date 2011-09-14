class Account < ActiveRecord::Base
  attr_accessible :name

  has_many :codes, :class_name => 'AuthenticationCode'
  has_many :accounts_web_apps, :dependent => :destroy
  has_many :accounts_users,    :dependent => :destroy

  has_many :web_apps, :through => :accounts_web_apps
  has_many :users,    :through => :accounts_users

  def admin_emails
    accounts_users.find_all_by_admin(true).collect { |au| au.user.email }
  end

  def user_data= data
    AccountsUser.destroy_all(:account_id => self.id)
    data.each do |user|
      user = user[1]
      unless user[:user_id].blank?
        accounts_users.build(user)
      end
    end
  end

  def web_app_data= data
    AccountsWebApp.destroy_all(:account_id => self.id)
    data.each do |web_app|
      web_app = web_app[1]
      unless web_app[:expires_on].blank? or web_app[:web_app_id].blank?
        accounts_web_apps.build(web_app)
      end
    end
  end
end
