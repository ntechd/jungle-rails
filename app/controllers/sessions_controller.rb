class SessionsController < ApplicationController
  def new; end

  def create
    if (user = User.authenticate_with_credentials(session_params))
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login', notice: 'Login failed, incorrect password or email'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  private

  def session_params
    params['/login'][:email].strip.downcase!
    params.require('/login').permit(
      :email,
      :password
    )
  end
end
