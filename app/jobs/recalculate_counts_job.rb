# class RecalculateCountsJob < ApplicationJob
#       queue_as :default

#       def perform
#         Application.find_each do |application|
#           application.update(chats_count: application.chats.count)
#           application.chats.find_each do |chat|
#             chat.update(messages_count: chat.messages.count)
#           end
#         end
#       end
# end

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
    