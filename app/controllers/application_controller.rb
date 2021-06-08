class ApplicationController < ActionController::API
    include Pagy::Backend
    #before_action :authorized

    #def encode_token(payload)
    #   JWT.encode(payload,'secret_key')
    #end

    #def auth_header
    #    puts "error23"

    #   request.headers['Authorization']
    #end

    #def decoded_token
    #    if auth_header
    #        token = auth_header.split(" ")[1]
    #        puts token

#            begin
 #               JWT.decode(token,'secret_key',true,algorithm: 'HS256')
  #          rescue JWT::DecodeError
   #             nil
    #        end
     #   end
    #end

    #def logged_in_user
     #   if decoded_token
      #      user_id = decoded_token[0]['user_id']
       #     @user = User.find_by_id(user_id)
       #end
    #end

    #def logged_in?
    #    !!logged_in_user #devuelve true o false
    #end

    #def authorized
     #   render json: {message: "falta loggin"}, status: :unauthorized unless logged_in?
    #end
    
end
