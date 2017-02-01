class CreateGuestbooks < ActiveRecord::Migration[5.0]
  def change
    create_table :guestbooks do |t|
      t.string :title
      t.boolean :active

      t.timestamps
    end
  end
end
