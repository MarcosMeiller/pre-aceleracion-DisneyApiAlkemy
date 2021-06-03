class ApplicationController < ActionController::API
    #include Knock::Authenticable
    #before_action :authorized

    #def encode_token(payload)
    #   JWT.encode(payload,secret_key)
    #end

    #def auth_header
    #   request.headers['Authorization']
    #end

    #def decoded_token
    #    if auth_header
    #        token = auth_header.plit(" ")[1]
            
    #        begin
    #            JWT.decode(token,secret_key,true,algorithm: 'HS256')
    #        rescue JWT::decodeError
    #            nil
    #        end
    #    end
    #end

    #def logged_in_user
    #    if decoded_token
    #        user_id = decoded_token[0]['user_id']
    #       @user = User.find_by_id(user_id)
     #   end
    #end

#    def logged_in?
#        !!logged_in_user #devuelve true o false
 #   end
#
 #   def authorized
  #      render json: {message: "falta loggin"}, status: unauthorized unless logged_in?
   # end
end
