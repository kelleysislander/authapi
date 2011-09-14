require 'test_helper'

class AuthenticationCodesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => AuthenticationCode.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    AuthenticationCode.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    AuthenticationCode.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to authentication_code_url(assigns(:authentication_code))
  end
  
  def test_edit
    get :edit, :id => AuthenticationCode.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    AuthenticationCode.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AuthenticationCode.first
    assert_template 'edit'
  end
  
  def test_update_valid
    AuthenticationCode.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AuthenticationCode.first
    assert_redirected_to authentication_code_url(assigns(:authentication_code))
  end
  
  def test_destroy
    authentication_code = AuthenticationCode.first
    delete :destroy, :id => authentication_code
    assert_redirected_to authentication_codes_url
    assert !AuthenticationCode.exists?(authentication_code.id)
  end
end
