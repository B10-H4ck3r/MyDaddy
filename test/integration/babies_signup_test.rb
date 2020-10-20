require 'test_helper'

class BabiesSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Baby.count' do
      post babies_path, params: { baby: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'babies/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'Baby.count', 1 do
      post babies_path, params: { baby: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'babies/show'
  end

end
