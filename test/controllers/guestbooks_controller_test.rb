require 'test_helper'

class GuestbooksControllerTest < ActionDispatch::IntegrationTest
=begin
  setup do
    @guestbook = guestbooks(:guestbook_one)
  end

  test "should get index" do
    get guestbooks_url
    assert_response :success
  end

  test "should get new" do
    get new_guestbook_url
    assert_response :success
  end

  test "should create guestbook" do
    assert_difference('Guestbook.count') do
      post guestbooks_url, params: { guestbook: { archived: false, title: "Some title" } }
    end

    assert_redirected_to guestbook_url(Guestbook.last)
  end

  test "should show guestbook" do
    get guestbook_url(@guestbook)
    assert_response :success
  end

  test "should get edit" do
    get edit_guestbook_url(@guestbook)
    assert_response :success
  end

  test "should update guestbook" do
    patch guestbook_url(@guestbook), params: { guestbook: { archived: true, title: "New title" } }
    assert_redirected_to guestbook_url(@guestbook)
  end

  test "should destroy guestbook" do
    assert_difference('Guestbook.count', -1) do
      delete guestbook_url(@guestbook)
    end

    assert_redirected_to guestbooks_url
  end
=end
end
