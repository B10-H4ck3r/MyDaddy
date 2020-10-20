require 'test_helper'

class BabiesIndexTest < ActionDispatch::IntegrationTest


    def setup
      @admin     = babies(:test)
      @non_admin = babies(:archer)
    end

    test "index as admin including pagination and delete links" do
      log_in_as(@admin)
      get babies_path
      assert_template 'babies/index'
      assert_select 'div.pagination'
      first_page_of_babies = Baby.paginate(page: 1)
      first_page_of_babies.each do |baby|
        assert_select 'a[href=?]', baby_path(baby), text: baby.name
        unless baby == @admin
          assert_select 'a[href=?]', baby_path(baby), text: 'delete'
        end
      end
      assert_difference 'Baby.count', -1 do
        delete baby_path(@non_admin)
      end
    end

    test "index as non-admin" do
      log_in_as(@non_admin)
      get babies_path
      assert_select 'a', text: 'delete', count: 0
    end


end
