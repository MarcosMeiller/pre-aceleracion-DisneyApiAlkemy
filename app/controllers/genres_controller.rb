class GenresController < ApplicationController
    def index
        @genre = Genre.all
         render json: @genre
    
      end
    
      def show 
        @genre = Genre.find(params[:id])
        render json: @genre
      end
    
      def create
        @genre = Genre.new(genre_params)
        if @genre.save 
          render json: @genre, status: :created
        else 
          render status:401
        end
      end
    
      def update
        @genre = Genre.find(params[:id])
    
        if @genre.update(genre_params)
          render json: @genre, status: :accepted
        else
          render status:304
        end
      end
    
      def destroy
        @genre = Genre.find(params[:id])
        @genre.destroy
    
        redirect_to root_path
      end
    
      private 
      def genre_params
        params.require(:genre).permit(:name, :age, :weight, :history)
      end
end
