class Message < ApplicationRecord
      belongs_to :chat

      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks
    
      def as_indexed_json(options = {})
        self.as_json(only: [:body, :chat_id])
      end
    
      def self.search(query, chat_id)
        __elasticsearch__.search(
          {
            query: {
              bool: {
                must: [
                  { match: { body: query } },
                  { match: { chat_id: chat_id } }
                ]
              }
            }
          }
        )
      end
end