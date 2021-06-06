class MoviesController < ApplicationController
  #before_action :authenticate_user, only: [:create]
  def index
    @movies= Movie.all
     render json: @movies

  end

  def show 
    @movie = Movie.find(params[:id])
    render json: @movie
  end

  def create
    @movie = Movie.new(title: params[:title],image: params[:image],creation_date: params[:creation_date], rating: params[:rating])
    if params[:genres]
        params[:genres].each do |genre|      
          genre = Genre.find(genre[1])
          genre.movies << @movie
        end
      end
      if params[:characters]
        params[:characters].each do |character|      
          character = Character.find(character[1])
          character.movies << @movie
        end
      end
    
    #@movie = Movie.new(title: params[:title],image: params[:image],creation_date: params[:creation_date], rating: params[:rating])
    if @movie.save 
      render json: @movie, status: :created
    else 
      render status:401
    end
  end

   
  def movie_params
    params.require(:movie).permit(:title, :image, :creation_date, :rating)
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(title: params[:title],image: params[:image],creation_date: params[:creation_date], rating: params[:rating])
      if params[:genres]
        params[:genres].each do |genre|      
          genre = Genre.find(genre[1])
          genre.movies << @movie
        end
      end
      if params[:characters]
        params[:characters].each do |character|      
          character = Character.find(character[1])
          character.movies << @movie
        end
      end
      render json: @movie, status: :accepted
    else
      render status:304
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    redirect_to root_path
  end

  def search
    if params[:q] && params[:order] && params[:genre]
      genre = Genre.find(params[:genre])
      datoComparativo =  genre.movies
      movies = Movie.where(["title LIKE ?","%#{params[:q]}%"]).order("creation_date #{params[:order]}")
      dato = Array:movies
      movies.each do |movie|
        datoComparativo.each do |comparar| 
          if movie.title == comparar.title
            dato << movie
          else
            resultado = "no existe"
          end
        end
      end
    render json: dato
    end
    if params[:q] && params[:order] && !params[:genre]
      movies = Movie.where(["title LIKE ?","%#{params[:q]}%"]).order("creation_date #{params[:order]}")
      render json: movies
    end
    if params[:q] && !params[:order] && !params[:genre]
      movies = Movie.where(["title LIKE ?","%#{params[:q]}%"])
      render json: movies
    end
    if !params[:q] && !params[:order] && params[:genre]
      genre = Genre.find(params[:genre])
      datoComparativo =  genre.movies
      movies = Movie.all
      dato = Array:movies
      movies.each do |movie|
        datoComparativo.each do |comparar| 
          if movie.title == comparar.title
            dato << movie
          else
            resultado = "no existe"
          end
        end
      end
      render json: dato
      end
  end

end
