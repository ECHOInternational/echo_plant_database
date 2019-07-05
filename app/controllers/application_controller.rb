class ApplicationController < ActionController::API
	before_action :set_paper_trail_whodunnit
  def current_user
  	"Default User - replace this."
  end
end
