class Message < ApplicationRecord
  belongs_to :guestbook, optional: true

  validates :content, presence: true
end
