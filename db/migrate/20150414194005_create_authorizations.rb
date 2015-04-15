class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :token
      t.string :secret

      t.timestamps
    end

    add_index :authorizations, :provider
    add_index :authorizations, :uid
    add_index :authorizations, :user_id
  end
end
