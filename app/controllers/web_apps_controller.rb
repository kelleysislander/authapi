class WebAppsController < ApplicationController
  before_filter :login_required

  def index
    @web_apps = WebApp.all

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end
  
  def show
    @web_app = WebApp.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end
  
  def new
    @web_app = WebApp.new

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end
  
  def create
    @web_app = WebApp.new(params[:web_app])
    if @web_app.save
      flash[:notice] = "Successfully created web app."
      respond_to do |format|
        format.html { redirect_to @web_app }
        format.mobile { redirect_to @web_app }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.mobile { render :action => 'new' }
      end
    end
  end
  
  def edit
    @web_app = WebApp.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end
  
  def update
    @web_app = WebApp.find(params[:id])
    if @web_app.update_attributes(params[:web_app])
      flash[:notice] = "Successfully updated web app."

      respond_to do |format|
        format.html { redirect_to @web_app }
        format.mobile { redirect_to @web_app }
      end
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.mobile { render :action => 'edit' }
      end
    end
  end
  
  def destroy
    @web_app = WebApp.find(params[:id])
    @web_app.destroy
    flash[:notice] = "Successfully destroyed web app."
    respond_to do |format|
      format.html { redirect_to web_apps_url }
      format.mobile { redirect_to web_apps_url }
    end
  end
end
