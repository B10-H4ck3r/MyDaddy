require 'test_helper'

class BabyTest < ActiveSupport::TestCase

  def setup
    @baby = Baby.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar", date_price: "$15.99", text_price: "$20.99", sex: "Male")
  end

  test "should be valid" do
    assert @baby.valid?
  end

  test "name should be present" do
    @baby.name = "     "
    assert_not @baby.valid?
  end

  test "text price should be present" do
    @baby.text_price = "    "
    assert_not @baby.valid?
  end

  test "text price should not be too long" do
    @baby.text_price = "a" * 4
    assert_not @baby.valid?
  end

  test "date price should be present" do
    @baby.date_price = "    "
    assert_not @baby.valid?
  end

  test "date price should not be too long" do
    @baby.date_price = "a" * 4
    assert_not @baby.valid?
  end

  test "email should be present" do
    @baby.email = "     "
    assert_not @baby.valid?
  end

  test "name should not be too long" do
    @baby.name = "a" * 51
    assert_not @baby.valid?
  end

  test "email should not be too long" do
    @baby.email = "a" * 244 + "@example.com"
    assert_not @baby.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @baby.email = valid_address
      assert @baby.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @baby.email = invalid_address
      assert_not @baby.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_baby = @baby.dup
    @baby.save
    assert_not duplicate_baby.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @baby.email = mixed_case_email
    @baby.save
    assert_equal mixed_case_email.downcase, @baby.reload.email
  end

  test "password should be present (nonblank)" do
    @baby.password = @baby.password_confirmation = " " * 6
    assert_not @baby.valid?
  end

  test "password should have a minimum length" do
    @baby.password = @baby.password_confirmation = "a" * 5
    assert_not @baby.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @baby.authenticated?('')
  end

  test "sex should be present (nonblank)" do
    @baby.sex = ' ' * 6
    assert_not @baby.valid?
  end

  test "sex should have a minimum length" do
    @baby.sex = "a" * 9
    assert_not @baby.valid?
  end

  test "associated microposts should be destroyed" do
    @baby.save
    @baby.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @baby.destroy
    end
  end

end
