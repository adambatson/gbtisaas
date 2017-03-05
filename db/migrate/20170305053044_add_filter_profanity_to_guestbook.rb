class AddFilterProfanityToGuestbook < ActiveRecord::Migration[5.0]
  def change
    add_column :guestbooks, :filter_profanity, :boolean, :null => false
  end
end
