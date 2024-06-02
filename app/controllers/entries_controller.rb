class EntriesController < ApplicationController
  before_action :require_user

  def new
    @place = Place.find(params[:place_id])
    @entry = @place.entries.build
  end

  def create
    @place = Place.find(params[:place_id])
    @entry = @place.entries.build(entry_params)
    @entry.user_id = @current_user.id
    if @entry.save
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on)
  end
end
