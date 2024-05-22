class RecalculateCountsJob
      include Sidekiq::Job
    
      def perform
        Application.find_each do |application|
          UpdateChatsCountJob.perform_later(application.id)
          application.chats.find_each do |chat|
            UpdateMessagesCountJob.perform_later(chat.id)
          end
        end
      end
end
    