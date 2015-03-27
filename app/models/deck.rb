class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user
  
  before_validation :capitalize_name
  validates :name, presence: true

  def capitalize_name
    self.name =  self.name.titleize
  end
end
