class RenameColumnToCards < ActiveRecord::Migration
  def change
    rename_column :cards, :visual, :picture
  end
end
