class MoviesController < ApplicationController
  before_action :authenticate

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
    
    if @movie.save 
      render json: {msg: "created successfully", movie: @movie}, status: :created
    else 
      render status:401
    end
  end

   
  def movie_params #i had a error and i cant use it in the create and update method
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
    if params[:name] && params[:order] && params[:genre]
      genre = Genre.find(params[:genre])
      comparativeDate =  genre.movies
      movies = Movie.where(["title LIKE ?","%#{params[:name]}%"]).order("creation_date #{params[:order]}")
      listMovies = Array:movies
      movies.each do |movie|
        comparativeDate.each do |date| 
          if movie.title == date.title
            listMovies << movie
          end
        
      end
    
      end
      render json: {Movies: listMovies}
    end
    if params[:name] && params[:order] && !params[:genre]
      movies = Movie.where(["title LIKE ?","%#{params[:name]}%"]).order("creation_date #{params[:order]}")
      render json: {Movies: movies}
    end
    if params[:name] && !params[:order] && !params[:genre]
      movies = Movie.where(["title LIKE ?","%#{params[:name]}%"])
      render json: {Movies: movies}
    end
    if !params[:name] && !params[:order] && params[:genre]
      genre = Genre.find(params[:genre])
      dateComparative =  genre.movies
      movies = Movie.all
      moviesList = Array:movies
      movies.each do |movie|
        dateComparative.each do |date| 
          if movie.title == date.title
            moviesList << movie
          end
        end
      end
      render json: {Movies: moviesList}
    end
      if !params[:name] && !params[:order] && !params[:genre]
        @pagy, @movies= pagy(Movie.all)
        render json: {Movies: @movies,pagy: @pagy}
      end
    
  end
end
