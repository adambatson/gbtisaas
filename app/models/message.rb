class Message < ApplicationRecord
  belongs_to :guestbook, optional: true

  validates :content, presence: true

  validate :guestbook_not_archived

  def guestbook_not_archived
    if guestbook.archived
      errors.add(:guestbook, "archived, can't add new messages")
    end
  end

  def cast_vote up
    self.votes += up ? 1 : -1
    self.votes_cast += 1
    self.save
  end

end
