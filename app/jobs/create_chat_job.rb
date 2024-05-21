class CreateChatJob < ApplicationJob
      queue_as :default
    
      def perform(application_id)
        application = Application.find(application_id)
        chat_number = application.next_chat_number
        application.chats.create!(number: chat_number)
        UpdateChatsCountJob.perform_later(application_id)
      end
end
    