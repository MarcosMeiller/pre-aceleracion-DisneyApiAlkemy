class MoviesController < ApplicationController
  before_action :authenticate_user, only: [:auth]
  def index
    @movie = Movie.all
     render json: @movie

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

  private 
  def movie_params
    params.require(:movie).permit(:title, :image, :creation_date, :rating)
  end
end
