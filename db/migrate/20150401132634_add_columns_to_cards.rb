class AddColumnsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :box, :integer, default: 0
    add_column :cards, :fail_count, :integer, default: 0
  end
end
