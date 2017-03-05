class AccessKey < ApplicationRecord
  before_create :default_values
  belongs_to :guestbook, optional: true
  validates :label, presence: true

  def self.validate(key)
    AccessKey.where(key: key).count > 0
  end

  def default_values
    begin
      self.key = SecureRandom.hex(16)
    end while AccessKey.where(key: self.key).count > 0
  end
end
