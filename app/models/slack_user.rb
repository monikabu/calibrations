# == Schema Information
#
# Table name: slack_users
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string
#  slack_token :string
#  confirmed   :boolean
#

class SlackUser < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :slack_token, presence: true
  validates :user_id, presence: true
end
