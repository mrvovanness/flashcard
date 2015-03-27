class User < ActiveRecord::Base
  has_many :decks
  has_many :cards, through: :decks
  authenticates_with_sorcery!

  with_options unless: "password.nil?" do
    validates :password, length: { minimum: 4 }
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
  end
  validates :email, uniqueness: true
end
