class AddColumnToCards < ActiveRecord::Migration
  def change
    add_column :cards, :picture, :integer
  end
end
