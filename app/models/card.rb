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

  def check_translation(user_translation)
    case DamerauLevenshtein.distance(
      original_text.downcase.strip, user_translation.downcase.strip, 0
    )
    when 0 then self.fail_count = 0
    else increment(:fail_count)
    end

    update_attributes(fail_count: [self.fail_count, 3].min,
                      number_of_reviews: calculate_number_of_reviews,
                      review_date: calculate_new_review_date,)

    return !(self.fail_count > 0)
  end

  def calculate_number_of_reviews
    case fail_count
    when 0 then [number_of_reviews + 1, 4].min
    when 3 then 0
    else number_of_reviews
    end
  end

  def calculate_new_review_date
    return DateTime.now if fail_count == 3
    return review_date if fail_count != 0

    case number_of_reviews
    when 0 then DateTime.now + 12.hours
    when 1 then DateTime.now + 3.days
    when 2 then DateTime.now + 1.weeks
    when 3 then DateTime.now + 2.weeks
    else DateTime.now + 1.months
    end
  end
end
