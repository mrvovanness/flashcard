class AddColumnToCards < ActiveRecord::Migration
  def change
    add_column :cards, :deck_id, :integer, index: true
  end
end
