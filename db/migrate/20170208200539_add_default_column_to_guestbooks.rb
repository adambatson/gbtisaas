class AddDefaultColumnToGuestbooks < ActiveRecord::Migration[5.0]
  def change
    add_column :guestbooks, :is_default, :boolean, :default => false
  end
end
