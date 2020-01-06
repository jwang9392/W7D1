class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to cats_url
            flash[:success] = 'User has been created. Welcome to 99cats'
        else
            flash.now[:errors] = 'Creation failed. Try Again'
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end