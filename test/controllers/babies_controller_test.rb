require 'test_helper'

class BabiesControllerTest < ActionDispatch::IntegrationTest


    def setup
      @baby = babies(:test)
      @other_baby = babies(:archer)
    end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get babies_path
    assert_redirected_to login_url
  end


  test "should redirect edit when not logged in" do
    get edit_baby_path(@baby)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch baby_path(@baby), params: { baby: { name: @baby.name,
                                              email: @baby.email,
                                              date_price: @baby.date_price,
                                              text_price: @baby.text_price } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_baby)
    get edit_baby_path(@baby)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_baby)
    patch baby_path(@baby), params: { baby: { name: @baby.name,
                                              email: @baby.email,
                                              date_price: @baby.date_price,
                                              text_price: @baby.text_price } }
    assert flash.empty?
    assert_redirected_to root_url
  end


end
