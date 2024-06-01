class EntriesController < ApplicationController
  before_action :require_user

  def new
  end

  def create
    @entry = Entry.new
    @entry.title = params[:title]
    @entry.description = params[:description]
    @entry.occurred_on = params[:occurred_on]
    @entry.place_id = params[:place_id]
    @entry.user_id = @current_user.id
    if @entry.save
      redirect_to place_path(@entry.place_id)
    else
      render :new
    end
  end
end
