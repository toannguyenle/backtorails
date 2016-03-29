require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:toan)
    @other_user = users(:ha)
    @admin = users(:admin)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit user when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update user when not logged in" do
    patch :update, id: @user, user: {
      name: @user.name,
      email: @user.email
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as a wrong user" do
    log_in_as @other_user
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as a wrong user" do
    log_in_as @other_user
    patch :update, id: @user, user: {
      name: @user.name,
      email: @user.email
    }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @admin
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not admin" do
    log_in_as(@user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
end
