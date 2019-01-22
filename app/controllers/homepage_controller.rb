require 'rqrcode'

class HomepageController < ApplicationController

	def index
		if session[:user_id] == nil
			redirect_to new_user_path
		else
			@qr = encode
			render :index
		end
	end
	
	def encode
		RQRCode::QRCode.new(session[:user_id].to_s)
	end

end