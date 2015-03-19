class AddPicToCards < ActiveRecord::Migration
  def change
    add_column :cards, :card_pic, :string
  end
end
