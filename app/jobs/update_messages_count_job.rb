class UpdateMessagesCountJob < ApplicationJob
      queue_as :default
    
      def perform(chat_id)
        chat = Chat.find(chat_id)
        chat.update(messages_count: chat.messages.count)
      end
end