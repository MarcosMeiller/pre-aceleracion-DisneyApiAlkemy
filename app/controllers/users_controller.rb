class UsersController < ApplicationController
    #before_action :authenticate_user, only: [:auth]

    def index
        user = User.last
        render json: user.to_json
    end


    def create
        @user = User.new(username: params[:username],password: params[:password], email: params[:email])
        if @user.save
            UserMailer.signup_welcome(@user).deliver
            render json: {status: 200, msg: 'El usuario ha sido creado'}
        else
            render json: { msg: 'no se pudo crear'}
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
