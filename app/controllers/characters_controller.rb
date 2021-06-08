class CharactersController < ApplicationController
  before_action :authenticate
    def index
      @pagy, @characters= pagy(Character.select('name','image'))
      render json: {Characters: @characters,pagy: @pagy}
    end
    
    def show 
      @character = Character.find(params[:id])
      movies = @character.movies
      render json: {Character: @character, Movies: movies}
    end
    
    def create
      @character = Character.new(character_params)
      if @character.save 
        if params[:movies]
          params[:movies].each do |movie_id|      
            movie = Movie.find(movie_id[1])
            @character.movies << movie
        end
          end
        render json: {character: @character,msg: "created successfully"}, status: :created
        else 
          render status:401
      end
    end
    
    def update
      @character = Character.find(params[:id])
    
      if @character.update(character_params)
        if params[:movies]
          params[:movies].each do |movie_id|      
            movie = Movie.find(movie_id[1])
            @character.movies << movie
          end
        end
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
    
    def search
      
        #movie = Movie.find(params[:movie])
        #datoComparativo =  movie.characters
        if(params[:name] && params[:age] && !params[:movie])
          characters = Character.where(["name LIKE ?","%#{params[:name]}%"]).where(age: params[:age].to_i)
          render json: characters
        end
        if (params[:name] && params[:age] && params[:movie])
          characters = Character.where(["name LIKE ?","%#{params[:name]}%"]).where(age: params[:age].to_i)
          movie = Movie.find(params[:movie])
          datoComparativo =  movie.characters
          peliculaFiltrada = Array:characters
          characters.each do |character|
            datoComparativo.each do |comparar| 
              if character.name == comparar.name && character.id == comparar.id
                peliculaFiltrada << character
              end
            end
          end
          render json: peliculaFiltrada
        end
        if params[:name] && !params[:age] && !params[:movie]
          characters = Character.where(["name LIKE ?","%#{params[:name]}%"])
          render json: characters

        end
        if !params[:name] && !params[:age] && params[:movie]
          movie = Movie.find(params[:movie])
          characters =  movie.characters
          render json: characters


        end
        if !params[:name] && params[:age] && !params[:movie]
          characters = Character.where(age: params[:age].to_i)
          render json: characters

        end
        if !params[:name] && !params[:age] && !params[:movie]
          characters = Character.all
          render json: characters
        end
    end
      
    private 
    def character_params
      params.require(:character).permit(:name, :age, :weight, :history)
    end
end
