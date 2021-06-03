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
    @movie = Movie.new(movie_params)
    if @movie.save 
      render json: @movie, status: :created
    else 
      render status:401
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
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
    
    genre = Genre.find(params[:genre])
    @movie = Movie.where(["title LIKE ?","%#{params[:q]}%"]).order("creation_date #{params[:order]}")
    @variable = @movie(genre)
    render json: @variable
    #if params[:order].present?
    #  @movie = Movie.where(["title LIKE ?","%#{params[:q]}%"]).order("creation_date #{params[:order]}")
    #else
    #  @movie = Movie.where(["title LIKE ?","%#{params[:q]}%"])
    #end
    
    #if @movie
    #  if params[:genre].present? && @movie.length() > 1 && @movie.kind_off?(array)
    #    genre = Genre.find(params[:genre])
    #    @movie.each {|n|
    #      if n.genres == genre
    #        @movies << n
    #      end
    #    }
    #    @movie = @movies

 #     else
  #      genre = Genre.find(params[:genre])
   #     if @movie.genres != genre
    #      @movie = nil
     #   end
      #end
      #render json: @movie
    #else
    #  render json: Movie.all
    #end
  end

  private 
  def movie_params
    params.require(:movie).permit(:title, :image, :creation_date, :rating)
  end
end
