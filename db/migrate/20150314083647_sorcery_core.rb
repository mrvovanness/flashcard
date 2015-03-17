class SorceryCore < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :password, :crypted_password
      t.string :salt
      t.index :email, unique: true
    end
  end
end
