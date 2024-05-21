class Chat < ApplicationRecord
      belongs_to :application
    
      has_many :messages, dependent: :destroy
      
      validates :number, presence: true  


      def next_message_number
        max_number = $redis.get("chat_#{id}_max_message_number").to_i
        new_number = max_number + 1
        $redis.set("chat_#{id}_max_message_number", new_number)
        new_number
      end
end