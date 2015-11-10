class CreateGoogleToken < ActiveRecord::Migration
  def change
    create_table :google_tokens do |t|
      t.integer :user_id
      t.string :token
      t.string :refresh_token
      t.datetime :expires_at

      t.timestamps
    end

    add_index :google_tokens, [:user_id, :token]
  end
end
