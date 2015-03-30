class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user
  validates :name, presence: true

  def current?(user)
    self == user.current_deck
  end
end
