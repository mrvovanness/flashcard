class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
