require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:toan)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template('users/edit')
    patch user_path(@user), user: { 
      name: '',
      email: 'foo@invalid',
      password: 'foo',
      password_confirmation: 'bar'
    }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template('users/edit')
    patch user_path(@user), user: {
      name: 'New Toan',
      email: 'newtoan@toan.com'
    }
    assert_not flash.empty?, "Flash message should not be empty"
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, 'New Toan'
    assert_equal @user.email, 'newtoan@toan.com'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    patch user_path(@user), user: {
      name: 'New Toan',
      email: 'newtoan@toan.com'
    }
    assert_not flash.empty?, "Flash message should not be empty"
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, 'New Toan'
    assert_equal @user.email, 'newtoan@toan.com'
  end

  test "user cannot set admin attribute" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template('users/edit')
    patch user_path(@user), user: {
      name: 'New Toan',
      email: 'newtoan@toan.com',
      admin: true
    }
    assert_not flash.empty?, "Flash message should not be empty"
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, 'New Toan'
    assert_equal @user.email, 'newtoan@toan.com'
    assert_equal @user.admin, nil
  end
end
