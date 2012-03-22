require 'Time_Local'
class AuthenticateController < ApplicationController
	def auth
		public_key = params[:public_key]
		hash_auth = params[:hash_auth]

		keys_app = KeyApp.find_by_public_key(public_key)

		@private_key = keys_app.private_key

		time = Time_Local.new
		@t = time.now

		

	end

	
end
