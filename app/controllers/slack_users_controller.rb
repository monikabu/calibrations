class SlackUsersController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    SlackUser.create!(slack_user_params)
    render text: "An integration request has been created"
  end

  private

  def slack_user_params
    attributes = params.permit(:token, :user_name, :text)
    attributes[:slack_token] = attributes.delete(:token)
    attributes[:name] = attributes.delete(:user_name)
    attributes[:user_id] = find_user_by_email(attributes.delete(:text)).id
    attributes
  end

  def find_user_by_email(email)
    User.find_by!(email: email)
  end
end
