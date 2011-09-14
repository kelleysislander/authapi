require 'digest/sha1'

class User < ActiveRecord::Base
  acts_as_authentic

  has_many :accounts_users
  has_many :accounts, :through => :accounts_users
  has_and_belongs_to_many :web_apps, :finder_sql => 'SELECT DISTINCT web_apps.id, web_apps.name, web_apps.url FROM web_apps, accounts_web_apps, accounts_users WHERE accounts_web_apps.account_id IN (SELECT account_id FROM accounts_users WHERE user_id = #{id}) AND web_apps.id = accounts_web_apps.web_app_id', :delete_sql => 'SELECT 1'

  attr_accessible :username, :email, :password, :password_confirmation, :account_ids, :admin

  def auth_code= hash_code
    auth = AuthenticationCode.find_by_hash_code(hash_code) rescue nil

    if auth
      self.accounts << auth.account
      auth.destroy if self.save
    else
      errors.add_to_base "Invalid authorization code."
    end
  end

  def is_admin? account = nil
    return true if admin == true

    if account
      AccountsUser.find_by_account_id_and_user_id(account.id, id).admin rescue false
    else
      admin == true
    end
  end

  def is_account_admin?
    return true if is_admin?
    Account.all.each { |a| return true if is_admin?(a) }
    false
  end

  def to_s
    "#{username}"
  end

  def latest_expiration_date_for app
    AccountsWebApp.all.select { |aw|
      aw.account.users.include? self and aw.web_app == app
    }.collect { |aw|
      aw.expires_on
    }.max
  end

  def self.authenticate(username, password)
    return nil if username.blank? || password.blank?
    u = find_by_username(username.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def username=(value)
    write_attribute :username, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
end
