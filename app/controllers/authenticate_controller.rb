class AuthenticateController < ApplicationController
	def auth
		@client_id = params[:client_id]
	end
end
