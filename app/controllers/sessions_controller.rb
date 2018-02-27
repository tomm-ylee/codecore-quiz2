class SessionsController < ApplicationController
  def create
    if @user = User.find_by(email: params[:session][:email])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.first_name}"
      redirect_to root_path
    else
      flash[:alert] = "Email not found"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

end
