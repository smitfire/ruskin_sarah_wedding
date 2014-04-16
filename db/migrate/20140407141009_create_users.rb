class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
     	t.string :first 
     	t.string :last 
     	t.string :email 
     	t.string :password
      t.string :attendance
     	t.string :newsletter
      t.integer :meal
      t.integer :plus_one
      t.text :reply

      t.timestamps
    end
  end
end
