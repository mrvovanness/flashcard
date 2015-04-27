class Card < ActiveRecord::Base
  belongs_to :deck
  mount_uploader :picture, PictureUploader

  before_validation :set_review_date, on: :create
  
  validates :original_text,
            :translated_text,
            :review_date,
            :deck_id,
            presence: true

  validate :the_text_cannot_be_the_same

  scope :pending, -> {
    where("review_date <=?", DateTime.now).order("RANDOM()")
  }

  def the_text_cannot_be_the_same
    if original_text == translated_text
      errors.add(:translated_text, "не похоже на перевод")
    end
  end

  def set_review_date
    self.review_date = DateTime.now
  end

  def check_translation(card, user_translation, response_time)
    data = TranslationVerificator.new(card,
                                      user_translation,
                                      response_time).result
    update_attributes(review_date: data[:calculated_review_date],
                      number_of_reviews: data[:calculated_number_of_reviews],
                      e_factor: data[:calculated_e_factor],
                      interval: data[:calculated_interval])
    data
  end
end
