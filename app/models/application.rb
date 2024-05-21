class Application < ApplicationRecord
      validates :name, presence: true

      before_create :generate_token
      
      has_many :chats, dependent: :destroy


      def next_chat_number
            max_number = $redis.get("application_#{id}_max_chat_number").to_i
            new_number = max_number + 1
            $redis.set("application_#{id}_max_chat_number", new_number)
            new_number
      end

      private 

      def generate_token
            self.token = SecureRandom.hex(10)
      end
end