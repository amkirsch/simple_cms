require 'test_helper'

# What should I test? Anything you want to work.. - K

class DemoControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
