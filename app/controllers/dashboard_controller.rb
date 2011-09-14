class DashboardController < ApplicationController
  before_filter :login_required
  layout 'application'

  def index
    respond_to do |format|
      format.html
      format.mobile
    end
  end
end
