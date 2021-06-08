class ApplicationController < ActionController::API
    include Pagy::Backend

    def authenticate
        authorization_header = request.headers[:authorization]
        if (!authorization_header)
            render json:"no ha podido ingresar por falta de token", status: :unauthorized
        else
            token = authorization_header.split(" ")[1]
            secret_key = Rails.application.secrets.secret_key_base[0]
            decoded_token = JWT.decode(token,secret_key)[0]

            @user = User.find(decoded_token["user_id"])
        end

    end
    
    
end
