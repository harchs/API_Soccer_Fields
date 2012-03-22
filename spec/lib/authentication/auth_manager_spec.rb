require "auth_manager"
require "spec_helper"
require "KeysManager"

describe Auth_manager do 
	describe "text auth" do
		it " #Should validate the hash generated is the same as the hash send by the client" do
			#from the BD
			public_key_int="abcd"
			private_key_int="efgh"
			auditor = Auth_manager.new(public_key_int, private_key_int, KeysManager.new)
			#from the client
			params = Hash.new(0)
			params['dataExamp1']="casa"
			params['dataExamp2']="casa2"

			public_key_ext=public_key_int
			private_key_ext=private_key_int
			params['public_key']=public_key_ext
			#generate hash that sould come from the client
			key_manager=KeysManager.new
			hash_ext=key_manager.secure_digest(private_key_ext, params)
			#validation of the hash
			result = auditor.authenticate(public_key_ext, hash_ext, params, nil)
			result.should == true	
		end 
	end
	
end