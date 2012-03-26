
require 'KeysManager'
require 'auth_manager'
class AuthenticateController < ApplicationController
	#http://prueba.local:3000/authenticate?public_key='your public key'&hash_auth='your private key encoded'
	def auth
		public_key = params[:public_key]
		hash_auth = params[:hash_auth]

		keys_app = KeyApp.find_by_public_key(public_key)

		@private_key = keys_app.private_key

		time = Time_Local.new
		time_now_trunk_hour = time.nowTrunkToHours
		p "time:"+time_now_trunk_hour

		paramters = [time_now_trunk_hour, @private_key, public_key]

		auditor = Auth_manager.new(public_key, @private_key, KeysManager.new ) 
		@result = auditor.authenticate(public_key, hash_auth, paramters )

	end
end
