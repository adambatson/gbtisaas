require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  test "message without content should not save" do
    msg = Message.new
    assert_not msg.save
  end

end
