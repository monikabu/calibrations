class Users::Integration < ActiveRecord::Base
  validates :token, presence: true, uniqueness: true
  validates :user_name, presence: true
  validates :user_email, presence: true, uniqueness: true
end
