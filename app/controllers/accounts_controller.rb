class AccountsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :only => [ :new, :create, :destroy ]
  before_filter :account_admin_required, :only => [ :show, :edit, :update ]
  before_filter :any_account_admin_required

  def index
    @accounts = Account.all.select { |a| @current_user.is_admin? a }

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end
  
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end
  
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end
  
  def create
    params[:account][:web_app_data] ||= []
    params[:account][:user_data]    ||= []

    @account = Account.new(params[:account])
    @account.web_app_data = params[:account].delete(:web_app_data)
    @account.user_data    = params[:account].delete(:user_data)

    if @account.save
      flash[:notice] = "Successfully created account."
      respond_to do |format|
        format.html { redirect_to @account }
        format.mobile { redirect_to @account }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.mobile { render :action => 'new' }
      end
    end
  end
  
  def edit
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end
  
  def update
    params[:account][:web_app_data] ||= []
    params[:account][:user_data]    ||= []

    @account = Account.find(params[:id])
    begin
      @account.web_app_data = params[:account].delete(:web_app_data)
      @account.user_data    = params[:account].delete(:user_data)

      if @account.update_attributes(params[:account])
        flash[:notice] = "Successfully updated account."
        respond_to do |format|
          format.html { redirect_to @account }
          format.mobile { redirect_to @account }
        end
      else
        respond_to do |format|
          format.html { render :action => 'new' }
          format.mobile { render :action => 'new' }
        end
      end
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Expiration date can't be blank."
      respond_to do |format|
        format.html { render :action => 'new' }
        format.mobile { render :action => 'new' }
      end
    end
  end
  
  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    flash[:notice] = "Successfully destroyed account."
    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.mobile { redirect_to accounts_url }
    end
  end
end
