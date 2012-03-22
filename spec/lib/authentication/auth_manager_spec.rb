require "auth_manager"
require "spec_helper"
require "secret_manager"

describe Auth_manager do 
	describe "text auth" do
		it " #Should validate the hash generated is the same as the hash send by the client" do
			#from the BD
			public_key_int="abcd"
			private_key_int="efgh"
			auditor = Auth_manager.initialize(public_key_int, private_key_int, )
			#from the client
			public_key_int="abcd"
			private_key_int="efgh"
			params = Hash.new(0)
			params['dataExamp1']="casa"
			params[':dataExamp2']="casa2"
			params[':dataExamp2']="casa2"
			public_key_ext="abcd"
			params['public_key_ext']=public_key_ext


			result = auditor.authenticate(public_key_ext, hash_ext, )
			result.should == true	
		end 
	end
	
end