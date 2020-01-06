class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[user_name], params[password])

        if @user
          session[:session_token] = @user.reset_session_token!
          flash[:success] = 'Welcome back'
          redirect_to cats_url
        else  
          flash.now[:errors] = 'Wrong username/password combination'
          render :new
        end
    end

    def destroy
        @user.reset_session_token!
        self.session_token = nil
        flash[success] = 'Logged Out'
        redirect_to cats_url
    end
end