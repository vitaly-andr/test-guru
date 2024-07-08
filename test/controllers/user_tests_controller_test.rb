require "test_helper"

class UserTestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_tests_index_url
    assert_response :success
  end

  test "should get show" do
    get user_tests_show_url
    assert_response :success
  end

  test "should get new" do
    get user_tests_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_tests_edit_url
    assert_response :success
  end
end
