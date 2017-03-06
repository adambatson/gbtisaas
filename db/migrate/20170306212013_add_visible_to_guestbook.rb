class AddVisibleToGuestbook < ActiveRecord::Migration[5.0]
  def change
    add_column :guestbooks, :visible, :boolean, :default => true
  end
end
