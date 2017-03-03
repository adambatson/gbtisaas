class Guestbook < ApplicationRecord
  has_many :messages, :dependent => :destroy

  validates :title, presence: true
  validates :title, uniqueness: true

  def approved_messages
    l = lambda { |x| x.approved }
    self.messages.select(&l)
  end

  def toggle_default
    self.is_default = !self.is_default
    self.save
  end

  def self.get_default
    Guestbook.where("is_default=true").first
  end

  def sorted_messages(sort_by)
    messages = []
    case sort_by
    when :recent
      messages = Message.where(guestbook_id: self.id).order('created_at DESC')
    when :votes
      messages = Message.where(guestbook_id: self.id).order('votes DESC')
    when :alphabet
      messages = Message.where(guestbook_id: self.id).order('content ASC')
    when :controversial
      messages = Message.where(guestbook_id: self.id).order('(votes_cast - votes) DESC')
    else
      messages = Message.where(guestbook_id: self.id)
    end

    return messages
  end

end
