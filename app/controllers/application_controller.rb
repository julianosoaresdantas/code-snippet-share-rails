class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user! # Assuming you are using Devise

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
