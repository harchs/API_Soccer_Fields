 class Auth_manager
 	
 	attr_readonly: :public_key_int, :private_key_int, :encoder_impl

 	def initialize (public_key_int, private_key_int, encoder_impl)
 		:public_key_int = public_key_int
 		:private_key_int = private_key_int
 		:encoder_impl = encoder_impl
 	end

  	def authenticate(public_key_ext, hash_ext, params, modifiers)
  		#if the public keys are the same, it has to be validated with a DB outside this method anyway
  		if (:public_key_int == public_key_ext)
  			hash_int=:encoder_impl.secret_digest(private_key_int, params) 
  			if()
  		end
  	end

 end