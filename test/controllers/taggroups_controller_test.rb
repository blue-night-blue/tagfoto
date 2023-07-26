require "test_helper"

class TaggroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @taggroup = taggroups(:one)
  end

  test "should get index" do
    get taggroups_url
    assert_response :success
  end

  test "should get new" do
    get new_taggroup_url
    assert_response :success
  end

  test "should create taggroup" do
    assert_difference("Taggroup.count") do
      post taggroups_url, params: { taggroup: { group: @taggroup.group, sort_order: @taggroup.sort_order, user_id: @taggroup.user_id } }
    end

    assert_redirected_to taggroup_url(Taggroup.last)
  end

  test "should show taggroup" do
    get taggroup_url(@taggroup)
    assert_response :success
  end

  test "should get edit" do
    get edit_taggroup_url(@taggroup)
    assert_response :success
  end

  test "should update taggroup" do
    patch taggroup_url(@taggroup), params: { taggroup: { group: @taggroup.group, sort_order: @taggroup.sort_order, user_id: @taggroup.user_id } }
    assert_redirected_to taggroup_url(@taggroup)
  end

  test "should destroy taggroup" do
    assert_difference("Taggroup.count", -1) do
      delete taggroup_url(@taggroup)
    end

    assert_redirected_to taggroups_url
  end
end
