require "application_system_test_case"

class ApprovedUsersTest < ApplicationSystemTestCase
  setup do
    @approved_user = approved_users(:one)
  end

  test "visiting the index" do
    visit approved_users_url
    assert_selector "h1", text: "Approved users"
  end

  test "should create approved user" do
    visit approved_users_url
    click_on "New approved user"

    fill_in "Approved user", with: @approved_user.approved_user
    check "Authenticated" if @approved_user.authenticated
    fill_in "User", with: @approved_user.user_id
    click_on "Create Approved user"

    assert_text "Approved user was successfully created"
    click_on "Back"
  end

  test "should update Approved user" do
    visit approved_user_url(@approved_user)
    click_on "Edit this approved user", match: :first

    fill_in "Approved user", with: @approved_user.approved_user
    check "Authenticated" if @approved_user.authenticated
    fill_in "User", with: @approved_user.user_id
    click_on "Update Approved user"

    assert_text "Approved user was successfully updated"
    click_on "Back"
  end

  test "should destroy Approved user" do
    visit approved_user_url(@approved_user)
    click_on "Destroy this approved user", match: :first

    assert_text "Approved user was successfully destroyed"
  end
end
