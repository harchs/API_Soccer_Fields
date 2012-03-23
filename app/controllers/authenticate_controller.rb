require 'Time_Local'
require 'KeysManager'
class AuthenticateController < ApplicationController
	#http://prueba.local:3000/authenticate?public_key='your public key'&hash_auth='your private key encoded'
	def auth
		public_key = params[:public_key]
		hash_auth = params[:hash_auth]

		keys_app = KeyApp.find_by_public_key(public_key)

		@private_key = keys_app.private_key

		time = Time_Local.new
		@t = time.now

		keyManager = KeysManager.new
		@hash_authR = keyManager.secure_digest(@t,@private_key,public_key)
	end
end
