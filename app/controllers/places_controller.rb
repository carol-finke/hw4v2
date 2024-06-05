class PlacesController < ApplicationController
  before_action :require_login

  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to places_path, notice: "Place added!"
    else
      render :new
    end
  end

  def show
    @place = Place.find(params[:id])
    @entries = @place.entries.where(user: current_user) # Ensuring only current user's entries are shown
    @entry = @place.entries.build if logged_in?
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :location)
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in to access this page."
    end
  end

  def logged_in?
    !!session[:user_id]
  end
end
