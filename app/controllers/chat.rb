class Chat < ApplicationRecord
      belongs_to :application
      before_create :set_chat_number
    
      private
    
      def set_chat_number
        self.number = application.chats.maximum(:number).to_i + 1
      end
end