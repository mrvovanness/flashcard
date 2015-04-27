class ChangeNumberOfReviewsColumnOfCards < ActiveRecord::Migration
  def change
    change_table :cards do |t|
      t.remove :number_of_reviews
      t.integer :number_of_reviews, default: 0
    end
  end
end
