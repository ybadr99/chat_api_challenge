class CreateMessageJob < ApplicationJob
      queue_as :default
      
      def perform(chat_id, body)
         chat = Chat.find(chat_id)
         message_number = chat.next_message_number
         chat.messages.create!(number: message_number, body: body)
         UpdateMessagesCountJob.perform_later(chat_id)
      end
end
    