class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :latest_uploads

  def latest_uploads
    @latest_uploads = FishFile.limit(5).order("created_at DESC").all
  end
end
