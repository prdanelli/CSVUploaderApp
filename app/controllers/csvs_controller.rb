class CsvsController < ApplicationController
  before_action :ensure_user_logged_in!

  protected

  def ensure_user_logged_in!
    return if current_user.present?

    redirect_to root_path, flash: { error: "You must be logged into access this area" }
  end
end
