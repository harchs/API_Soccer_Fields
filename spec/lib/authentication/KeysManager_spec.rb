require "spec_helper"

describe KeysManager do 
	describe "create_PublicKey" do
	    it "returns http success" do
	      get 'create'
	      response.should be_success
	    end
  end
	
end