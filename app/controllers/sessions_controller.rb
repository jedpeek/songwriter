class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if auth_hash = request.env['omniauth.auth']
      user = User.find_or_create_by_omniauth(auth_hash)
      user.save
      session[:user_id] = user.id
      redirect_to controller:'users', action:'index'
    else
      #standard login
      user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to controller:'users', action:'index'
        else
          render 'sessions/new'
        end
      end
    end

    def destroy
      reset_session
      redirect_to login_path
    end
end
