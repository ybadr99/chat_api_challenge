class AddIndexesToChatsAndMessages < ActiveRecord::Migration[7.1]
  def change
    add_index :chats, [:application_id, :number], unique: true
    add_index :messages, [:chat_id, :number], unique: true
  end
end
