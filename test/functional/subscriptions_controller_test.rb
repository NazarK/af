require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get confirm" do
    get :confirm
    assert_response :success
  end

  test "should get cancel" do
    get :cancel
    assert_response :success
  end

  test "should get error" do
    get :error
    assert_response :success
  end

end
