class Guestbook < ApplicationRecord
  has_many :messages, :dependent => :destroy

  validates :title, presence: true
  validates :title, uniqueness: true

  def as_json(options={})
    super(include: :messages)
  end

  def approved_messages
    l = lambda { |x| x.approved }
    self.messages.select(&l)
  end

  def unapproved_messages
    l = lambda { |x| !x.approved }
    self.messages.select(&l)
  end

  def toggle_default
    self.is_default = !self.is_default
    self.save
  end

  def archive
    self.archived = true
    self.save
  end

  def self.get_default
    Guestbook.where("is_default=true").first
  end

  def sorted_messages(sort_by)
    messages = []
    query = Message.where(guestbook_id: self.id).where(approved: true)
    case sort_by
    when :recent
      messages = query.order('created_at DESC')
    when :votes
      messages = query.order('votes DESC')
    when :alphabet
      messages = query.order('content ASC')
    when :controversial
      messages = query.order('(votes_cast - votes) DESC')
    else
      messages = query
    end

    return messages
  end
end
