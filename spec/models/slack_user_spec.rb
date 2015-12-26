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

require 'rails_helper'

describe SlackUser do
  describe 'validations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slack_token) }
  end
end
