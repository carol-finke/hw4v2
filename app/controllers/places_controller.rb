class PlacesController < ApplicationController
  before_action :require_user, only: [:new, :create, :show]

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by(id: params[:id])
    @entries = Entry.where(place_id: @place.id, user_id: @current_user.id)
  end

  def new
  end

  def create
    @place = Place.new
    @place.name = params[:name]
    if @place.save
      redirect_to places_path
    else
      render :new
    end
  end
end
