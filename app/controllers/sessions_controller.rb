class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      Rails.logger.debug "User found: #{user.inspect}"
    else
      Rails.logger.debug "No user found with email: #{params[:email]}"
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      Rails.logger.debug "Session user_id set to: #{session[:user_id]}"
      flash[:notice] = "Hello."
      redirect_to places_path
    else
      flash[:notice] = "Invalid email/password combination."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Goodbye."
    redirect_to login_path
  end
end
