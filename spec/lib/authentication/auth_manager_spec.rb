require "auth_manager"
require "spec_helper"
require "KeysManager"

describe Auth_manager do 
	describe "test auth" do
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
			#add options to validat with date
			params[:valid_date]=true
			options = Hash.new
			options[:valid_date]==params[:valid_date]
			# deprecated
			# time = Time_Local.new
			# params['date_trunk_hour']=time.nowTrunkToHours
			
			#generate hash that sould come from the client
			key_manager=KeysManager.new
			hash_ext=key_manager.secure_digest(params)
			#validation of the hash
			result = auditor.authenticate(public_key_ext, hash_ext, params, options)
			result.should == true	
		end 
	end
	
end