class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
     	t.string :first 
     	t.string :last 
     	t.string :email 
     	t.string :password_digest, null: false
      t.string :password_confirmation
     	t.boolean :attendance

      t.timestamps
    end
  end
end
