require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "Example User",
      email: "toan@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  test "should be a valid user" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name shouldn't be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email shouldn't be too long" do
    @user.email = "a"*250 + "@email.com"
    assert_not @user.valid?
  end

  test "should be valid with valid email addresses" do
    valid_addresses = %w[toan@me.com u_123@u-34.com user@example.com.org]
    valid_addresses.each do |e|
      @user.email = e
      assert @user.valid?, "#{e.inspect} should be valid"
    end
  end

  test "should be reject invalid email addresses" do
    invalid_addresses = %w[toanme.com u_123@a+34.com user@example@com.org]
    invalid_addresses.each do |e|
      @user.email = e
      assert_not @user.valid?, "#{e.inspect} should not be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should save user email as downcase" do
    @user.email = "UPPER@eASt.com"
    @user.save
    assert @user.email == 'upper@east.com'
  end

  test "password should be at minimum length" do
    @user.password = @user.password_confirmation = "12345"
    assert_not @user.valid?
  end

  test "authenticated? should return false a for a user with nil remember digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed once the user is deleted" do
    @user.save
    @user.microposts.create!(content: "Be gone in a sec")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    toan = users(:toan)
    ha = users(:ha)
    assert_not toan.following?(ha)
    toan.follow(ha)
    assert toan.following?(ha)
    assert ha.followers.include?(toan)
    toan.unfollow(ha)
    assert_not toan.following?(ha)
  end

  test "feed should have the right posts" do
    toan = users(:toan)
    bill = users(:bill)
    admin = users(:admin)

    # Posts from followed user
    bill.microposts.each do |post_following|
      assert toan.feed.include?(post_following)
    end

    # Post from self
    toan.microposts.each do |post_self|
      assert toan.feed.include?(post_self)
    end

    # Posts from unfollowed user
    admin.microposts.each do |post_unfollowed|
      assert_not toan.feed.include?(post_unfollowed)
    end
  end
end
