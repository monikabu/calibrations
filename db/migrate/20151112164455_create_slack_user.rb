class CreateSlackUser < ActiveRecord::Migration
  def change
    create_table :slack_users do |t|
      t.integer :user_id
      t.string :name
      t.string :slack_token
    end

    add_index :slack_users, :slack_token
  end
end
