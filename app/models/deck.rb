class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user
  validates :name, presence: true

  def current?(user_id)
    id == User.find(user_id).current_deck
  end
end
