require 'test_helper'

class BabiesLoginTest < ActionDispatch::IntegrationTest

  def setup
    @baby = babies(:test)
  end

  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:    @baby.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @baby.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @baby
    follow_redirect!
    assert_template 'babies/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", baby_path(@baby)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", baby_path(@baby), count: 0
  end

  test "login with remembering" do
    log_in_as(@baby, remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@baby, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@baby, remember_me: '0')
    assert_empty cookies[:remember_token]
  end

end
