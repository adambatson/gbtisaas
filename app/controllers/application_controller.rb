class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  before_action :set_title

  def set_title
  	@title = "Writing in the air"
  end
end
