class AddNameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.text :about
      t.string :location
      t.string :username
    end
  end
end
