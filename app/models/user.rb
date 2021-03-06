class User < ActiveRecord::Base
  has_many :decks
  has_many :cards, through: :decks
  belongs_to :current_deck, class_name: "Deck"

  authenticates_with_sorcery!

  before_validation :set_default_locale, on: :create
  validates :locale, presence: true, on: :create
  validates :email, uniqueness: true
  with_options unless: "password.nil?" do
    validates :password, length: { minimum: 4 }
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
  end

  def set_default_locale
    self.locale = I18n.locale
  end

  def self.notify_pending_cards
    joins(:cards).uniq.where("review_date <= ?", DateTime.now).each do |user|
      NotificationsMailer.pending_cards(user)
    end
  end
end
