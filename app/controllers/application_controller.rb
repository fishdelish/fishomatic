class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :latest_uploads

  def latest_uploads
    @latest_uploads = []
  end
end
