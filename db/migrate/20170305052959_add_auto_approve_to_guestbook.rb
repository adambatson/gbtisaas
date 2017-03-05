class AddAutoApproveToGuestbook < ActiveRecord::Migration[5.0]
  def change
    add_column :guestbooks, :auto_approve, :boolean, :null => false
  end
end
