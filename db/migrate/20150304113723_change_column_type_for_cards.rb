class ChangeColumnTypeForCards < ActiveRecord::Migration
  def change
    change_column :cards, :review_date, 'date USING CAST(review_date AS date)' 
  end
end
