require 'open-uri'
require 'uri'

class FishFilesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @fish_file = FishFile.new
  end

  def create
    @fish_file = current_user.fish_files.new(params[:fish_file])
    @fish_file.save!
    redirect_to fish_file_path(@fish_file), :notice => "Created FISH file"
  rescue 
    flash.now[:error] = "Failed to save fish file"
    render :action => :new
  end

  def edit
    @fish_file = current_user.fish_files.find(params[:id])
  end

  def update
    @fish_file = current_user.fish_files.find(params[:id])
    @fish_file.update_attributes!(params[:fish_file])
    redirect_to fish_file_path(@fish_file), :notice => "Updated FISH file"
  rescue
    flash.now[:error] = "Failed to update fish file"
    render :action => :new
  end

  def destroy
    @fish_file = current_user.fish_files.find(params[:id])
    @fish_file.destroy!
    redirect_to user_fish_files_path(current_user)
  rescue
    redirect_to fish_file_path(@fish_file), :error => "Couldn't destroy fish file"
  end

  def index
    if params[:user_id]
      @fish_files = current_user.fish_files
    else
      @fish_files = FishFile.all
    end
  end

  def show
    @fish_file = FishFile.find(params[:id])
  end
  
  def display
    unless @fish_file = ExternalFishFile.where(:url => params[:fish_file]).first
      @fish_file = ExternalFishFile.create!(:url => params[:fish_file])
    end
  end

  def file_location
    @fish_file = ExternalFishFile.first(params[:id])
    send_file @fish_file.data, :type => 'application/rdf+xml', :filename => @fish_file.name    
  end
end
