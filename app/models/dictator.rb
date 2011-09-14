require 'digest/md5'
require 'base64'

class Dictator
  def self.access(options = {})
    login       = options.delete(:login)
    web_app_id  = options.delete(:web_app_id)

    user = User.find_by_username(login)
    apps = user.web_apps

    return 200 if user.is_admin?

    if apps.collect{|wa| wa.name.downcase}.include? web_app_id
      dates    = []
      accounts = user.accounts.all

      for account in accounts
        a = AccountsWebApp.find_all_by_account_id(account.id)
        a.each { |c| dates << c.expires_on if c.web_app.name.downcase == web_app_id }
      end

      if dates.max >= Date.today
        return 200
      else
        return 401
      end
    end

    return 401
  end
end
