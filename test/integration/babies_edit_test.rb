require 'test_helper'

class BabiesEditTest < ActionDispatch::IntegrationTest
  def setup
    @baby = babies(:test)
  end

  test "unsuccessful edit" do
    log_in_as(@baby)
    get edit_baby_path(@baby)
    assert_template 'babies/edit'
    patch baby_path(@baby), params: { baby: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'babies/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_baby_path(@baby)
    log_in_as(@baby)
    assert_redirected_to edit_baby_url(@baby)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch baby_path(@baby), params: { baby: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @baby
    @baby.reload
    assert_equal name,  @baby.name
    assert_equal email, @baby.email
  end

end
