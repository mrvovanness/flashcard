class User < ActiveRecord::Base
  has_many :decks
  has_many :cards, through: :decks
  authenticates_with_sorcery!

  with_options unless: :deck_update? do
    validates :password, length: { minimum: 4 } 
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
    validates :email, uniqueness: true
  end
  attr_accessor :updating_deck
  
  def deck_update?
    updating_deck
  end
    
end
