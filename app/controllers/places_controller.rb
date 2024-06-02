class PlacesController < ApplicationController
  before_action :authenticate_user

  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])
    @entries = @place.entries
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:notice] = "Place created successfully."
      redirect_to places_path
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :description)
  end

  def authenticate_user
    # Add authentication logic here if needed
  end
end
