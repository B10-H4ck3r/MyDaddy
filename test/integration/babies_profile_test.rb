require 'test_helper'

class BabiesProfileTest < ActionDispatch::IntegrationTest


  def setup
    @baby = babies(:test)
  end

  test "profile display" do
    get baby_path(@baby)
    assert_template 'babies/show'
    assert_select 'title', full_title(@baby.name)
    assert_select 'h1', text: @baby.name
    assert_select 'h1>img.gravatar'
    assert_match @baby.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @baby.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

end
