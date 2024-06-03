class CreateChatJob < ApplicationJob
      queue_as :default
    
      def perform(application_id, chat_number)
        application = Application.find(application_id)
        application.chats.create!(number: chat_number)
        UpdateChatsCountJob.perform_later(application_id)
      end
end
    