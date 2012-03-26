 class Auth_manager
 	
 	attr_accessor :public_key_int, :private_key_int, :encoder_impl

 	def initialize (public_key_int, private_key_int, encoder_impl)
 		@public_key_int = public_key_int
 		@private_key_int = private_key_int
 		@encoder_impl = encoder_impl
 	end

  	def authenticate(public_key_ext, hash_auth_ext, params, options)
  		#if the public keys are the same, it has to be validated with a DB outside this method anyway
  		if (public_key_int == public_key_ext)
        if options[:valid_date]==true
          time = Time_Local.new
          time_now_trunk_hour = time.nowTrunkToHours
          params.push(time_now_trunk_hour)
        end
  			hash_auth_int=encoder_impl.secure_digest(params)
  			# p "hash in:"+hash_auth_int
  			if(hash_auth_int==hash_auth_ext)
  				return true
  			else
  				return false
  			end
  		else
  			return false
  		end
  	end

 end