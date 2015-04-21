class ChangeColumnDefaultsForUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :locale, "en"
  end
end
