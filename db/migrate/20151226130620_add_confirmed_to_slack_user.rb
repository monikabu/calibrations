class AddConfirmedToSlackUser < ActiveRecord::Migration
  def change
    add_column :slack_users, :confirmed, :boolean
  end
end
