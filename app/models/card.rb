class Card < ActiveRecord::Base
  before_validation :shift_date
  
  validates :original_text, :translated_text, :review_date, presence: true

  validate :the_text_cannot_be_the_same

  scope :pending, -> { where('review_date <=?', Date.today) }

  def the_text_cannot_be_the_same
    if original_text == translated_text
      errors.add(:translated_text, "не похоже на перевод")
    end
  end

  def shift_date
    self.review_date = Date.today + 3.days
  end

  def check_translation(user_translation)
    if user_translation == self.original_text
      self.update_attribute(:review_date, Date.today + 3.days)
    end
  end
end
