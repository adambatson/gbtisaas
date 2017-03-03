require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get guestbooks" do
    get admin_guestbooks_url
    assert_response :success
  end

  test "should get signatures" do
    get admin_signatures_url
    assert_response :success
  end

  test "should get access" do
    get admin_access_url
    assert_response :success
  end

  test "should get accounts" do
    get admin_accounts_url
    assert_response :success
  end

end
