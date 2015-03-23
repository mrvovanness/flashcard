class Card < ActiveRecord::Base
  belongs_to :deck
  mount_uploader :picture, PictureUploader

  before_validation :shift_date
  
  validates :original_text, :translated_text, :review_date, :deck_id, presence: true

  validate :the_text_cannot_be_the_same

  scope :pending, -> { where('review_date <=?', Date.today).order("RANDOM()") }

  def the_text_cannot_be_the_same
    if original_text == translated_text
      errors.add(:translated_text, "не похоже на перевод")
    end
  end

  def shift_date
    self.review_date = Date.today + 3.days
  end

  def check_translation(user_translation)
    if user_translation.mb_chars.downcase.strip == original_text.mb_chars.downcase.strip
      update_attributes(review_date: Date.today + 3.days)
    else
      return false
    end
  end
end
