class RenameColumnToCards < ActiveRecord::Migration
  def change
    rename_column :cards, :card_pic, :card_picture
  end
end
