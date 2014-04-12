class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
     	t.string :first 
     	t.string :last 
     	t.string :email 
     	t.string :password_digest
      t.string :password_confirmation
      t.string :attendance
     	t.string :newsletter
      t.string :meal
      t.string :plus_one
      t.text :reply

      t.timestamps
    end
  end
end
