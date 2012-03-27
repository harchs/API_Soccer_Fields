
require "spec_helper"

describe Api_controller do 
	describe "test auth json/xml response" do
		it " #Should return a xml/json with 'USER_CREDENTIAL_REQUIRED' error if the credential is not send " do
			api_controller = Api_controller.new 
			#create the json that should recive Api_controller
			json= Hash.new(0)
			json.push({
					"response" => {
						"user"=> {
							# "credential"=> "daCredential"
						}
					}
				})
			parsedJson= JSON(json)

			api_controller.instance_eval{ authenticate_user_token }
			# end this test checking the json response
			api_controller.instance_eval{ authenticate_user_token }.should eql ""
		end
	end
end