class MoviesController < ApplicationController
  before_action :set_movie, only: [ :show, :edit, :update, :destroy ]

  def index
    allowed = { "title" => "title", "rating" => "rating", "release_date" => "release_date" }
    @sort = allowed[params[:sort]] || "title"
    @dir  = %w[asc desc].include?(params[:dir]) ? params[:dir] : "asc"
  
    # Safe,  order
    @movies = Movie.order(@sort => @dir.to_sym)
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, notice: "Movie deleted."
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
