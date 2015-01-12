class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_filter :authenticate_user!

	# puts "*****In ApplicationController***************************************************"
	# get '/sms-quickstart' do
	#   twiml = Twilio::TwiML::Response.new do |response|
	#     response.Message "Thanks! Purple naranjos"
	#   end
	#   twiml.text
	# end
end