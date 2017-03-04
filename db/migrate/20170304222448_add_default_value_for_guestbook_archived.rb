class AddDefaultValueForGuestbookArchived < ActiveRecord::Migration[5.0]
  def change
    change_column_default :guestbooks, :archived, false
  end
end
