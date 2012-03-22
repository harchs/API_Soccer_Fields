
class KeysManager

	def create_PublicKey(appName)
		public_key = secure_digest(appName)
	end

	def create_SecretKey(appName,public_key)
		secret_key = secure_digest(appName,public_key)
	end

	def secure_digest(*args)
	      key = Digest::SHA1.hexdigest(args.flatten.join('--'))
	end
	

end