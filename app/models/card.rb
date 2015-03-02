class Card < ActiveRecord::Base
  before_validation do
    shift_date
  end
  
  validates :original_text, :translated_text, :review_date, presence: true

  validate :the_text_cannot_be_the_same

  def the_text_cannot_be_the_same
    if original_text == translated_text
      errors.add(:translated_text, "не похоже на перевод")
    end
  end

  def shift_date
    self.review_date = Date.today + 3.days
  end
end
