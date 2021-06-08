class AuthenticationController < ApplicationController
    #before_action :authorized

    def auto_login
        render json: @user, mesagge: "bienvenido"
    end
    
    def login
        @user = User.find_by(username: params[:username])
        if !@user
            render status: :unauthorized
        else
            if @user.authenticate(params[:password])
                secret_key = Rails.application.secrets.secret_key_base[0]
                puts secret_key
                token = JWT.encode(@user,'secret_key')
                puts "entre al login"
                render json: {user: @user, token: token}
            else
                render status: :unauthorized
            end
        end
    end
end
