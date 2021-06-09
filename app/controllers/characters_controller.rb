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
          comparativeDates =  movie.characters
          characterFiltered = Array:characters
          characters.each do |character|
            comparativeDates.each do |date| 
              if character.name == date.name && character.id == date.id
                characterFiltered << character
              end
            end
          end
          render json: characterFiltered
        end
        if !params[:name] && params[:age] && params[:movie]
          characters = Character.where(age: params[:age].to_i)
          movie = Movie.find(params[:movie])
          comparativeDates =  movie.characters
          peliculaFiltrada = Array:characters
          characters.each do |character|
            comparativeDates.each do |date| 
              if character.name == date.name && character.id == date.id
                peliculaFiltrada << character
              end
            end
          end
          render json:{results: peliculaFiltrada}
        end
        if params[:name] && !params[:age] && params[:movie]
          characters = Character.where(["name LIKE ?","%#{params[:name]}%"])
          movie = Movie.find(params[:movie])
          comparativeDates =  movie.characters
          peliculaFiltrada = Array:characters
          characters.each do |character|
            comparativeDates.each do |date| 
              if character.name == date.name && character.id == date.id
                peliculaFiltrada << character
              end
            end
          end
          render json:{results: peliculaFiltrada}
        end
        if params[:name] && !params[:age] && !params[:movie]
          characters = Character.where(["name LIKE ?","%#{params[:name]}%"])
          render json: {results: characters}

        end
        if !params[:name] && !params[:age] && params[:movie]
          movie = Movie.find(params[:movie])
          characters =  movie.characters
          render json: {results: characters}


        end
        if !params[:name] && params[:age] && !params[:movie]
          characters = Character.where(age: params[:age].to_i)
          render json: {results: characters}

        end
        if !params[:name] && !params[:age] && !params[:movie]
          characters = Character.all
          render json: {results: characters}
        end
    end
      
    private 
    def character_params 
      params.require(:character).permit(:name, :age, :weight, :history)
    end
end
