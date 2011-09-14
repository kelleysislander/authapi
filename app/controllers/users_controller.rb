class UsersController < ApplicationController
  before_filter :login_required, :except => [ :new, :create ]
  before_filter :admin_required_if_logged_in, :only => [ :new, :create ]

  def index
    @users = User.all

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end

  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path }
      format.mobile { redirect_to users_path }
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user"

      respond_to do |format|
        format.html { redirect_to users_path }
        format.mobile { redirect_to users_path }
      end
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.mobile { render :action => 'edit' }
      end
    end
  end

  def create
    @user = User.new(params[:user])
    @user.auth_code = params[:auth_code] unless current_user

    success = @user && @user.errors.empty? && @user.save

    respond_to do |format|
      if success && @user.errors.empty?
        flash[:notice] = 'New user created'
        format.html { redirect_to login_path }
        format.mobile { redirect_to login_path }
      else
        flash[:notice] = 'We could not set up that account'
        format.html { render :action => 'new' }
        format.mobile { render :action => 'new' }
      end
    end
  end
end
