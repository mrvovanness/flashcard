class User < ActiveRecord::Base
  has_many :decks
  has_many :cards, through: :decks
  belongs_to :current_deck, class_name: "Deck"

  authenticates_with_sorcery!

  validates :email, uniqueness: true
  with_options unless: "password.nil?" do
    validates :password, length: { minimum: 4 }
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
  end
end
