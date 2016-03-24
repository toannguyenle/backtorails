require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid sign up information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {
        name: "",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar"
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  test "valid sign up" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {
        name: "Example",
        email: "user@valid.com",
        password: "foobar",
        password_confirmation: "foobar"
      }
    end
    assert_template 'users/show'
    assert_not flash.nil?
  end
end
