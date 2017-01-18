class AddBookMessageRelationship < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.belongs_to :guestbook, index: true
    end
  end
end
