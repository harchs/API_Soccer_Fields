require 'spec_helper'

describe UserController do

  context 'params' do
    
  end

  context "GET 'sign_up'" do
    it "returns an json/xml with the response to the " do
      get 'sign_up'
      response.should be_success
    end
  end
end
