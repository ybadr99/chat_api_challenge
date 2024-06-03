class CreateMessageJob < ApplicationJob
      queue_as :default
      
      def perform(chat_id, body, message_number)
         chat = Chat.find(chat_id)
         chat.messages.create!(number: message_number, body: body)
         UpdateMessagesCountJob.perform_later(chat_id)
      end
end
    