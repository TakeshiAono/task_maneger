class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :basic_auth unless Rails.env.test?
  protect_from_forgery with: :exception
  before_action :login_required



  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def login_required
    redirect_to login_sessions_path unless current_user
  end

end
