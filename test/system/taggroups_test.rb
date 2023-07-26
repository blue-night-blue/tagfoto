require "application_system_test_case"

class TaggroupsTest < ApplicationSystemTestCase
  setup do
    @taggroup = taggroups(:one)
  end

  test "visiting the index" do
    visit taggroups_url
    assert_selector "h1", text: "Taggroups"
  end

  test "should create taggroup" do
    visit taggroups_url
    click_on "New taggroup"

    fill_in "Group", with: @taggroup.group
    fill_in "Sort order", with: @taggroup.sort_order
    fill_in "User", with: @taggroup.user_id
    click_on "Create Taggroup"

    assert_text "Taggroup was successfully created"
    click_on "Back"
  end

  test "should update Taggroup" do
    visit taggroup_url(@taggroup)
    click_on "Edit this taggroup", match: :first

    fill_in "Group", with: @taggroup.group
    fill_in "Sort order", with: @taggroup.sort_order
    fill_in "User", with: @taggroup.user_id
    click_on "Update Taggroup"

    assert_text "Taggroup was successfully updated"
    click_on "Back"
  end

  test "should destroy Taggroup" do
    visit taggroup_url(@taggroup)
    click_on "Destroy this taggroup", match: :first

    assert_text "Taggroup was successfully destroyed"
  end
end
