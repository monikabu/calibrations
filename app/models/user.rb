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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :trackable
  EMAIL_REGEXP = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\Z/i

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEXP }
  validates :password, presence: true

  has_one :google_token, dependent: :destroy
  has_one :slack_user, dependent: :destroy

  def self.from_omniauth(authorization)
    attributes = authorization.info
    user = User.where(email: attributes['email']).first

    unless user
      user = User.create!(name: attributes['name'],
         email: attributes['email'],
         password: Devise.friendly_token[0,20]
      )

      create_google_token(user, authorization.credentials)
    end
    user
  end

  def self.create_google_token(user, credentials)
    GoogleToken.create!(user_id: user.id,
      token: credentials['token'],
      refresh_token: credentials['refresh_token'],
      expires_at: Time.at(credentials['expires_at'])
    )
  end

  def authorization_token
    google_token.refresh! unless google_token.expires_at > Time.now
    google_token.token
  end
end
