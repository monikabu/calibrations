class CreateIntegrations < ActiveRecord::Migration
  def change
    create_table :integrations do |t|
      t.string :token
      t.string :user_name
      t.string :user_email
    end
  end
end
