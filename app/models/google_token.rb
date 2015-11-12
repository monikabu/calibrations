class GoogleToken < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :token, presence: true
  validates :refresh_token, presence: true
  validates :expires_at, presence: true
end
