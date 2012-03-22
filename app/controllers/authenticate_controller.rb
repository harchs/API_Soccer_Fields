class AuthenticateController < ApplicationController
	def auth
		client_id = params[:client_id]
		# @key = Digest::SHA1.hexdigest(client_id)
		key = 'casa'
		client_id_a = "hola"
		public_id = "public"

		@test = secure_digest(client_id_a,key,public_id)

		#toke: 4c10e727655abc7147ccff98b9bdc2ccf22c59ef
		#client_id
		#public_id

		#public_id y client_id el debe retornar el key



		#key optenido

		keyDB = 'caza'

		@testServer = secure_digest(client_id_a,keyDB,public_id)


	end

	def secure_digest(*args)
      	key = Digest::SHA1.hexdigest(args.flatten.join('--'))
      	key
    end
end
