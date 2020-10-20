require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @baby = babies(:test)
    remember(@baby)
  end

  test "current_user returns right baby when session is nil" do
    assert_equal @baby, current_baby
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    @baby.update_attribute(:remember_digest, Baby.digest(Baby.new_token))
    assert_nil current_baby
  end
end
