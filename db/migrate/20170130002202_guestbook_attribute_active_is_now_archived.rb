class GuestbookAttributeActiveIsNowArchived < ActiveRecord::Migration[5.0]
  def change
    rename_column :guestbooks, :active, :archived
  end
end
