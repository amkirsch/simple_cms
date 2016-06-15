require 'test_helper'

# What should I test? Anything you want to work.. - K
class AccessControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

end
