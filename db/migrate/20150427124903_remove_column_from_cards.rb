class RemoveColumnFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :fail_count, :integer
  end
end
