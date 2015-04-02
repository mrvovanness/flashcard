class ChangeColumnToCards < ActiveRecord::Migration
  def change
    rename_column :cards, :box, :number_of_reviews
  end
end
