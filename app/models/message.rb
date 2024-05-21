class Message < ApplicationRecord
      searchkick

      belongs_to :chat
end