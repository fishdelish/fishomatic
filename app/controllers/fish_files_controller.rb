require 'open-uri'
require 'uri'

class FishFilesController < ApplicationController
  before_filter :authenticate_user!, :only => [:update, :edit, :upload, :edit_file]

  def edit_file
    @user = current_user
  end

  def upload
    @user = current_user
    @user.update_attributes!(:fish_file => params[:user][:fish_file])
    redirect_to fish_files_user_url(:username => @user.username)
  rescue
    flash.now[:error] = "Something went wrong"
    render :action => :edit_file
  end

  def edit
    @user = current_user
  end

  def update
    redirect_to fish_files_user_url(:username => current_user.username)
  end

  def index
    @users = User.all
  end

  def show
    @user = User.where(:username => params[:username]).first
  end

  def get_file
    @user = params[:username] ? User.where(:username => params[:username]).first : current_user
    send_data @user.data, :type => 'application/rdf+xml', :filename => @user.username + ".rdf"
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
