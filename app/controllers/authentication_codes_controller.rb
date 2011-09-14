class AuthenticationCodesController < ApplicationController
  before_filter :login_required
  before_filter :get_account
  before_filter :admin_required

  def index
    @authentication_codes = @account.codes.all

    respond_to do |format|
      format.html
      format.mobile
    end
  end
  
  def new
    @authentication_code = AuthenticationCode.new
    @authentication_code.account = @account
    @authentication_code.hash_code = AuthenticationCode.random

    @authentication_code.save

    respond_to do |format|
      format.html
      format.mobile
    end
  end

  def generate
    if request.post?
      AuthenticationCode.generate(@account.id, params[:quantity], @current_user.email)

      respond_to do |format|
        flash[:notice] = "#{params[:quantity].to_i} codes generated."
        format.html { redirect_to account_authentication_codes_path(@account) }
        format.mobile { redirect_to account_authentication_codes_path(@account) }
      end
    else
      respond_to do |format|
        format.html
        format.mobile
      end
    end
  end

  def destroy_all
    @account.codes.destroy_all

    respond_to do |format|
      format.html { redirect_to account_authentication_codes_path(@account) }
      format.mobile { redirect_to account_authentication_codes_path(@account) }
    end
  end
  
  def create
    @authentication_code = @account.codes.build(params[:authentication_code])
    if @authentication_code.save and @authentication_code.send_email! @current_user.email
      flash[:notice] = "Successfully created authentication code."
      respond_to do |format|
        format.html { redirect_to account_authentication_codes_path(@account) }
        format.mobile { redirect_to account_authentication_codes_path(@account) }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.mobile { render :action => 'new' }
      end
    end
  end
  
  def update
    @authentication_code = @account.codes.find(params[:id])
    if @authentication_code.update_attributes(params[:authentication_code])
      flash[:notice] = "Successfully updated authentication code."
      respond_to do |format|
        format.html { redirect_to account_authentication_codes_path(@account) }
        format.mobile { redirect_to account_authentication_codes_path(@account) }
      end
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.mobile { render :action => 'edit' }
      end
    end
  end
  
  def destroy
    @authentication_code = @account.codes.find(params[:id])
    @authentication_code.destroy
    flash[:notice] = "Successfully destroyed authentication code."
    respond_to do |format|
      format.html { redirect_to account_authentication_codes_path(@account) }
      format.mobile { redirect_to account_authentication_codes_path(@account) }
    end
  end

  protected
  def get_account
    @account = Account.find(params[:account_id])
  end
end
