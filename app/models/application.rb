class Application < ApplicationRecord
      validates :name, presence: true

      before_create :generate_token
      
      has_many :chats, dependent: :destroy

      private 

      def generate_token
            self.token = SecureRandom.hex(10)
      end
end