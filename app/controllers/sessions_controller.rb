class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have been logged in successfully"

      return redirect_to user_csvs_path(user)
    end

    flash[:error] = "The email/password combination could not be found"
    render :new
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { success: "You have been logged out" }
  end
end
