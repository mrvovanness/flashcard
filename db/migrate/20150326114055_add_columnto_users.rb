class AddColumntoUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_deck_id, :integer
  end
end
