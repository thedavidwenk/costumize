require "test_helper"

class CostumesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get costumes_home_url
    assert_response :success
  end

  test "should get index" do
    get costumes_index_url
    assert_response :success
  end

  test "should get show" do
    get costumes_show_url
    assert_response :success
  end

  test "should get new" do
    get costumes_new_url
    assert_response :success
  end

  test "should get create" do
    get costumes_create_url
    assert_response :success
  end
end
