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

end
