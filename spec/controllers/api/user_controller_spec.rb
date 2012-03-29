require 'spec_helper'

describe Api::V1::UserController do
	it {{:post => "api/v1/user/sign_in"}.should route_to(:controller => "api/v1/user", :action => "sign_in", :format => "json")}
	it {{:post => "api/v1/user/sign_out"}.should route_to(:controller => "api/v1/user", :action => "sign_out", :format => "json")}
end

   describe "GET 'sign_up'" do
    it "returns an json/xml with the response to the " do
      get 'sign_up'
      response.should be_success
    end
  end


end
