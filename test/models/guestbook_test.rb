require 'test_helper'

class GuestbookTest < ActiveSupport::TestCase
  
  test "guestbook without a title should not save" do
    book = Guestbook.new
    assert_not book.save
  end

  test "guestbook titles must be unique" do
    guestbooks(:guestbook_one).save
    assert_not guestbooks(:duplicate_title).save
  end

end
