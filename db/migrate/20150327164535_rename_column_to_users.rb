class RenameColumnToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :current_deck_id, :current_deck
  end
end
