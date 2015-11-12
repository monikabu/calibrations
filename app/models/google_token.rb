class GoogleToken < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :token, presence: true
  validates :refresh_token, presence: true
  validates :expires_at, presence: true

  def refresh!
    request_params = {
      client_id: Calibration::Config.google.client_id,
      client_secret: Calibration::Config.google.client_secret,
      refresh_token: refresh_token,
      grant_type: "refresh_token"
    }

    response = JSON.parse(RestClient.post("https://accounts.google.com/o/oauth2/token", request_params))
    if response["access_token"].present?
      self.token = response["access_token"]
      self.expires_at = Time.now.utc + response["expires_in"].to_i.seconds
      self.save!
    else
      raise "Not able to refresh token"
    end
  end
end
