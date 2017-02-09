class AddDescriptionToGuestbooks < ActiveRecord::Migration[5.0]
  def change
    add_column :guestbooks, :description, :text
  end
end
