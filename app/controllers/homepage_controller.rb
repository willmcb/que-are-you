require 'rqrcode'

class HomepageController < ApplicationController

	def encode
		@qr = RQRCode::QRCode.new(session[:user_id].to_s)
		if session[:user_id] == 'undefined'
			redirect_to new_user_path
		else
		render :index
		end
  end

end
