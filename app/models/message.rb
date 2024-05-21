class Message < ApplicationRecord
      belongs_to :chat
      
      before_create :set_message_number
    
      validates :body, presence: true
    
      private
    
      def set_message_number
        self.number = chat.messages.maximum(:number).to_i + 1
      end
end