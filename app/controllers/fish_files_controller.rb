require 'open-uri'
require 'uri'

class FishFilesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :update, :edit, :create, :destroy]

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

  def full_new
  end

  def full_create
    @fish = current_user.fish_files.new
    @fish.build_file(params[:fish_file], request.session_options[:id])
    @fish.save!
    redirect_to fish_file_path(@fish), :notice => "Created FISH file"
  rescue
    flash.now[:error] = "Failed to create fish file"
    render :action => :full_new
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

  def file
    @fish_file = FishFile.find(params[:id])
    send_data @fish_file.data, :type => 'application/rdf+xml', :filename => @fish_file.name
  end
  
  def display
    unless @fish_file = ExternalFishFile.where(:url => params[:fish_file]).first
      @fish_file = ExternalFishFile.create!(:url => params[:fish_file])
    end
  end

  def file_location
    @fish_file = ExternalFishFile.find(params[:id])
    send_data @fish_file.data, :type => 'application/rdf+xml', :filename => @fish_file.name    
  end
end
