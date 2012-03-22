class Encoder
	def create_PublicKey(appName)
		raise NotImplementedError
	end

	def create_SecretKey(appName,public_key)
		raise NotImplementedError
	end

	def secure_digest(*args)
	    raise NotImplementedError
	end
end 