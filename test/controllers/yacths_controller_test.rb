require "test_helper"

class YacthsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get yacths_new_url
    assert_response :success
  end

  test "should get create" do
    get yacths_create_url
    assert_response :success
  end

  test "should get update" do
    get yacths_update_url
    assert_response :success
  end

  test "should get edit" do
    get yacths_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get yacths_destroy_url
    assert_response :success
  end

  test "should get index" do
    get yacths_index_url
    assert_response :success
  end

  test "should get show" do
    get yacths_show_url
    assert_response :success
  end
end
