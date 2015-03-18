class User < ActiveRecord::Base
  has_many :cards
  authenticates_with_sorcery!

  validates :password, length: { minimum: 4 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
  
end
