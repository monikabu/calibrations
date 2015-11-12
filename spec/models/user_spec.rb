# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string
#  last_sign_in_ip    :string
#  created_at         :datetime
#  updated_at         :datetime
#

require 'rails_helper'

describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    describe 'email' do
      let(:user) { build(:user) }
      subject { user }

      context 'allows correct emails' do
        it { is_expected.to allow_value('john@example.com').for(:email) }
        it { is_expected.to allow_value('test+a@22.com').for(:email) }
        it { is_expected.to allow_value('1_2_3@123.com').for(:email) }
      end

      context 'rejects incorrect emails' do
        it { is_expected.not_to allow_value('incorrect@example,com').for(:email) }
        it { is_expected.not_to allow_value('double@@example.com').for(:email) }
        it { is_expected.not_to allow_value('space @example.com').for(:email) }
      end

      context 'does not allow email duplication' do
        let!(:existing_user) { create(:user, email: 'already@taken.com') }

        it 'rejects already taken emails' do
          user.email = 'already@taken.com'
          expect(user.valid?).to be_falsey
        end
      end
    end
  end

  describe '.from_omniauth' do
    let(:authorization_hash) do
      OpenStruct.new(
        'info' => {
          'name' => 'John Doe',
          'email' => 'john@example.com'
        },
        'credentials' => {
          'token' => 'google_token',
          'refresh_token' => 'google_refresh_token',
          'expires_at' => "#{2.days.from_now}"
        })
    end

    context 'new user' do
      it 'creates new user' do
        expect { User.from_omniauth(authorization_hash) }.to change { User.count }
      end

      it 'creates google token' do
        expect { User.from_omniauth(authorization_hash) }.to change { GoogleToken.count }
      end
    end

    context 'user already exists' do
      let!(:user) { create(:user) }

      it 'does not create new user' do
        expect { User.from_omniauth(authorization_hash) }.not_to change { User.count }
      end

      it 'finds and returns existing user' do
        returned_user = User.from_omniauth(authorization_hash)
        expect(returned_user).to eq user
      end
    end
  end
end
