class AddVotesToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :votes, :Integer
  end
end
