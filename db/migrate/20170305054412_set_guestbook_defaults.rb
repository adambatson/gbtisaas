class SetGuestbookDefaults < ActiveRecord::Migration[5.0]
  def change
    change_column_default :guestbooks, :auto_approve, false
    change_column_default :guestbooks, :filter_profanity, false
  end
end
