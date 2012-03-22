class KeyApp < ActiveRecord::Base

    def self.save_keys(params)
		create! do |app|
			app.public_key = params["public_key"]
			app.private_key = params["private_key"]
			app.app_name = params["app_name"]
		end
	end
end
