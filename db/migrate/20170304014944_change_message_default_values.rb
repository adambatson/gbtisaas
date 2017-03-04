class ChangeMessageDefaultValues < ActiveRecord::Migration[5.0]
  def change
    change_column_default :messages, :approved, true
    change_column_default :messages, :votes, 0
  end
end
