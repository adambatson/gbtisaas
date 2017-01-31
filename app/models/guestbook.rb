class Guestbook < ApplicationRecord
  has_many :messages, :dependent => :destroy

  validates :title, presence: true
  validates :title, uniqueness: true
end
