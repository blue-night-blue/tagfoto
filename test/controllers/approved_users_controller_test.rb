require "test_helper"

class ApprovedUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @approved_user = approved_users(:one)
  end

  test "should get index" do
    get approved_users_url
    assert_response :success
  end

  test "should get new" do
    get new_approved_user_url
    assert_response :success
  end

  test "should create approved_user" do
    assert_difference("ApprovedUser.count") do
      post approved_users_url, params: { approved_user: { approved_user: @approved_user.approved_user, authenticated: @approved_user.authenticated, user_id: @approved_user.user_id } }
    end

    assert_redirected_to approved_user_url(ApprovedUser.last)
  end

  test "should show approved_user" do
    get approved_user_url(@approved_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_approved_user_url(@approved_user)
    assert_response :success
  end

  test "should update approved_user" do
    patch approved_user_url(@approved_user), params: { approved_user: { approved_user: @approved_user.approved_user, authenticated: @approved_user.authenticated, user_id: @approved_user.user_id } }
    assert_redirected_to approved_user_url(@approved_user)
  end

  test "should destroy approved_user" do
    assert_difference("ApprovedUser.count", -1) do
      delete approved_user_url(@approved_user)
    end

    assert_redirected_to approved_users_url
  end
end
