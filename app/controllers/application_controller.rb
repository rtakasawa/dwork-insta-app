class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    if current_user.nil?
      flash[:notice] = "権限がありません"
      redirect_to new_session_url
    end
  end
end