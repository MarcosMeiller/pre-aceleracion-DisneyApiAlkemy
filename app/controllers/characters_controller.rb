class CharactersController < ApplicationController
  #before_action :authenticate_user, only: [:create]

    def index
        @character = Character.all
         render json: @character
    
      end
    
      def show 
        @character = Character.find(params[:id])
        render json: @character
      end
    
      def create
        @character = Character.new(character_params)
        if @character.save 
          render json: @character, status: :created
        else 
          render status:401
        end
      end
    
      def update
        @character = Character.find(params[:id])
    
        if @character.update(character_params)
          render json: @character, status: :accepted
        else
          render status:304
        end
      end
    
      def destroy
        @character = Character.find(params[:id])
        @character.destroy
    
        redirect_to root_path
      end
    
      private 
      def character_params
        params.require(:character).permit(:name, :age, :weight, :history)
      end
end
