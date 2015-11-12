# == Schema Information
#
# Table name: google_tokens
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  token         :string
#  refresh_token :string
#  expires_at    :datetime
#  created_at    :datetime
#  updated_at    :datetime
#

require 'rails_helper'

describe GoogleToken do
  describe 'validations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_uniqueness_of(:user_id) }
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_presence_of(:refresh_token) }
    it { is_expected.to validate_presence_of(:expires_at) }
  end
end
