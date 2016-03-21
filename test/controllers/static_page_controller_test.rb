require 'test_helper'

class StaticPageControllerTest < ActionController::TestCase
  def setup
    @base_title = "Ruby on Rails"
  end
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "shoult get about" do
    get :about
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

end
