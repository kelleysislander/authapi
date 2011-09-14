class UserSessionsController < ApplicationController
  def splash
    respond_to do |format|
        format.html { redirect_to login_path }
        format.mobile { render :action => 'splash' }
    end
  end

  def new
    @user_session = UserSession.new

    if current_user
      redirect_to dashboard_path
    end
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        flash[:notice] = 'Successfully logged in'

        format.html { redirect_to dashboard_path }
        format.mobile { redirect_to dashboard_path }
      else
        

        format.html {
          @epic_failure = true
          render :action => 'new'
        }
        format.mobile { 
          @epic_failure = true
          render :action => 'new'
        }
      end
    end
  end
  
  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy

    respond_to do |format|
      format.html do
        flash[:notice] = "Successfully logged out"
        redirect_to login_path
      end
      format.json do
        render :json => { :success => 'Successfully logged out' }.to_json
      end
      format.mobile do
        flash[:notice] = "Successfully logged out"
        redirect_to login_path
      end
    end
  rescue
    redirect_to login_path
  end
end
