class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
     
    @sort = params[:sort] #retrieve sort field
    @all_ratings = Movie.all_ratings
    ratings = @all_ratings
    if params[:ratings] != nil
      ratings = params[:ratings].keys
    end
    
    @ratings_checked = Hash.new
    @all_ratings.each do |rating|
      @ratings_checked [rating] = 1
      if !(ratings.include?(rating))
        @ratings_checked [rating] = 0
      end
    end
    
    
    #flash[:notice] = "Parameter #{params} was passed to the controller" #for debugging purposes
    flash[:notice] = ratings[0]
    #@movies = Movie.find :all, :order => @sort, :conditions => ":rating => ratings"
    
    @movies = Movie.where(:rating => ratings)
    @movies = @movies.find :all, :order => @sort
    
    #@movies = Movie.find(:conditions => {:rating => , :order => @sort)
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
