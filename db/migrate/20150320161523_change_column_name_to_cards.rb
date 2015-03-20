class ChangeColumnNameToCards < ActiveRecord::Migration
  def change
    rename_column :cards, :card_picture, :visual
  end
end
