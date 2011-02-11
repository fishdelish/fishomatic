class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :latest_uploads

  def latest_uploads
    @latest_uploaders = User.order("updated_at DESC").limit(5).all
  end
end
