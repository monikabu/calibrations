class Users::IntegrationsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @integrations = Users::Integration.all
  end

  def create
    Users::Integration.create!(integration_params)
  end

  private

  def integration_params
    attributes = params.permit(:token, :user_name, :command)
    attributes[:user_email] = attributes.delete(:command).split('calibrations:').second
    attributes
  end
end
