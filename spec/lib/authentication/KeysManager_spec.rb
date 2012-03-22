require "spec_helper"
require 'KeysManager'

describe KeysManager do 
	describe "create_PublicKey" do
		it "#Should params not nil" do
			a = nil	
  			keyManager = KeysManager.new
  			publicKey = keyManager.create_PublicKey(a)
  			if publicKey == 'da39a3ee5e6b4b0d3255bfef95601890afd80709'
  				result = true
  			else
  				result = false
  			end
  			result.Should == false
		end
  	end
	
end