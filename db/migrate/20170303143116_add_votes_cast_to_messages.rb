class AddVotesCastToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :votes_cast, :int, :default => 0
    Message.update_all('votes_cast = votes')
  end
end
