class SessionsController < ApplicationController
  def create
    byebug
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      return redirect_to user_csv_index_path
    end

    render :new, flash: { error: "The email/password combination could not be found" }
  end
end
