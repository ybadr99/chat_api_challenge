class AddDefaultValuesToCounts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :applications, :chats_count, 0
    change_column_default :chats, :messages_count, 0
  end
end
