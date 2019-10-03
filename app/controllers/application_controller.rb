class ApplicationController < ActionController::API
  before_action :set_paper_trail_whodunnit

  def current_user
  	"Default User - replace this."
  end
  # WARNING! It is expected that token validation is being done by the API gateway
  # this assumes that everything included in the JWT comes from the authorization
  # server and has not been tampered with.
  # def authenticate_user
  # 	if request.headers['Authorization'].present?
  # 		authenticate_or_request_with_http_token do |token|
  # 			begin
  # 				jwt_payload = JWT.decode(token, nil, false)
  # 			rescue
  # 			end
  # 		end
  # 	end
  # end
end
