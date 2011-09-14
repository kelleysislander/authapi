class WebApp < ActiveRecord::Base
  attr_accessible :name, :url, :description, :account_ids
  has_many :accounts_web_apps
  has_many :accounts, :through => :accounts_web_apps

  def expired?
    begin
      unless expires_on.blank?
        return Date.today > Date.parse(expires_on)
      end

      false
    rescue
      false
    end
  end

  def to_s
    name
  end
end
