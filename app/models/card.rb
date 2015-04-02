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

  scope :pending, -> { where('review_date <=?', DateTime.now).order("RANDOM()") }

  def the_text_cannot_be_the_same
    if original_text == translated_text
      errors.add(:translated_text, "не похоже на перевод")
    end
  end

  def set_review_date
    self.review_date = DateTime.now
  end

  def check_translation(user_translation)
    if user_translation.mb_chars.downcase.strip == original_text.mb_chars.downcase.strip
      update_attributes(review_date: review_shift, box: box_shift, fail_count: 0)
    else
      update_attributes(fail_count: fail_count + 1)
      if fail_count == 3
        update_attributes(review_date: DateTime.now + 12.hours, box: 1, fail_count: 0)
      end
      return false
    end
  end

  def review_shift
    if box == 0
      DateTime.now + 12.hours
    elsif box == 1
      DateTime.now + 3.days
    elsif box == 2
      DateTime.now + 1.weeks
    elsif box == 3
      DateTime.now + 2.weeks
    elsif box == 4
      DateTime.now + 1.months
    end
  end

  def box_shift
    if box < 4
      box + 1
    else
      4
    end
  end
end
