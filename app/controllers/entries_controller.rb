class EntriesController < ApplicationController
  before_action :require_login
  before_action :set_place, only: [:new, :create, :index]

  def index
    @entries = @place.entries.where(user_id: session["user_id"]) # Ensure only current user's entries are shown
  end

  def new
    @entry = @place.entries.build
  end

  def create
    @entry = @place.entries.build(entry_params)
    @entry.user = current_user
    if @entry.save
      @entry.uploaded_image.attach(params[:entry][:uploaded_image])
      redirect_to place_path(@place), notice: "Entry added!"
    else
      render :new
    end
  end

  def destroy
    @entry = @place.entries.find_by(id: params[:id], user_id: session["user_id"]) # Ensure entry belongs to current user
    if @entry
      @entry.destroy
    end
    redirect_to place_path(@place)
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :uploaded_image)
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in to access this page."
    end
  end

  def logged_in?
    !!session[:user_id]
  end

  def set_place
    @place = Place.find(params[:place_id])
  end
end
