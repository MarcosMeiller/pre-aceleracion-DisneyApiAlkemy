class UsersController < ApplicationController
    before_action :authenticate_user, only: [:auth]
      #before_action: authorized

    def auto_login
        render json: @user, mesagge: "bienvenido"
    end

    def index
        user = User.last
        render json: user.to_json
    end


    def create
        user = User.new(user_params)
        if user.save
            render json: {status: 200, msg: 'El usuario ha sido creado'}
        else
            render json: {status: 400, msg: 'El usuario no se creo'}
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
