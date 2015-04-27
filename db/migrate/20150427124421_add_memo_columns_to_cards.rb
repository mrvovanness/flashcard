class AddMemoColumnsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :e_factor, :float, default: 2.5
    add_column :cards, :interval, :integer, default: 0
  end
end
