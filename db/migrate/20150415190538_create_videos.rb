class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :link
      t.string :title
      t.datetime :published_at
      t.integer :likes
      t.integer :dislikes
      t.string :uid
      t.references :user, index: true, foreign_key: true
      
      t.timestamps
    end
    add_index :videos, :uid
  end
end