require 'test_helper'

class WebAppsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => WebApp.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    WebApp.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    WebApp.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to web_app_url(assigns(:web_app))
  end
  
  def test_edit
    get :edit, :id => WebApp.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    WebApp.any_instance.stubs(:valid?).returns(false)
    put :update, :id => WebApp.first
    assert_template 'edit'
  end
  
  def test_update_valid
    WebApp.any_instance.stubs(:valid?).returns(true)
    put :update, :id => WebApp.first
    assert_redirected_to web_app_url(assigns(:web_app))
  end
  
  def test_destroy
    web_app = WebApp.first
    delete :destroy, :id => web_app
    assert_redirected_to web_apps_url
    assert !WebApp.exists?(web_app.id)
  end
end
