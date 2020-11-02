require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @baby = babies(:test)
  end

  test "micropost interface" do
    log_in_as(@baby)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # Correct pagination link
    # Valid submission
    content = "This micropost really ties the room together"
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete post.
    assert_select 'a', text: 'delete'
    first_micropost = @baby.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # Visit different user (no delete links).
    get baby_path(babies(:archer))
    assert_select 'a', { text: 'delete', count: 0 }
  end

  test "micropost sidebar count" do
    log_in_as(@baby)
    get root_path
    assert_match "#{FILL_IN} microposts", response.body
    # User with zero microposts
    other_baby = babies(:malory)
    log_in_as(other_baby)
    get root_path
    assert_match "0 microposts", response.body
    other_baby.microposts.create!(content: "A micropost")
    get root_path
    assert_match FILL_IN, response.body
  end

end
