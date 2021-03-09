# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    if params[:ratings]!= nil
    parametro_rating= params[:ratings].keys
    clausula="\"#{parametro_rating[0]}\"=rating"
    parametro_rating.each do |a|clausula=clausula+" or \"#{a}\"=rating"end
    @movies = Movie.where(clausula)
  else
    @movies = Movie.all
  end
    if params[:sort_by]!= nil
      parametro_sort= params[:sort_by]
      @movies = @movies.sort_by {|m| m[:"#{parametro_sort}"]}
    end
  end

  def show
    id = params[:id]
    teste= params
    @movie = Movie.find(id)
  end

  def new
    @movie = Movie.new
  end

  def create
    #@movie = Movie.create!(params[:movie]) #did not work on rails 5.
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created!"
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title,:rating,:description,:release_date)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
    #@movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])#did not work on rails 5.
    @movie.update(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated!"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted!"
    redirect_to movies_path
  end
  def @all_ratings.each(&block)
    Movie.all_ratings.each(&block)
  end
end