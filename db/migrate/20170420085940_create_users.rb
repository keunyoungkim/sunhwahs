class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :name 
      t.string :profile_image 
      t.string :token 
      t.string :secret 
      t.string :provider 
      t.string :uid
      
      t.timestamps null: false
    end
  end
end
