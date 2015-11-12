class Google::CalendarsController < Google::Base

  def index
    response = get('calendar/v3/users/me/calendarList')
    respond_to do |format|
      format.json { render json: JSON.parse(response.body) }
    end
  end

  private

  def get(path)
    token = current_user.authorization_token
    url = BASE_URL + path

    RestClient.get(url, { Authorization: "Bearer #{token}" })
  end
end
